//
//  FirebaseService.swift
//  Calendar
//
//  Created by Vy Le on 5/24/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift

class FirebaseService {
    private var database: Firestore!
    private var auth: Auth!
    static let shared = FirebaseService()
    private var calendar: Calendar
    private var components: DateComponents
    
    // MARK: - Initializer
    init() {
        database = Firestore.firestore()
        auth = Auth.auth()
        calendar = Calendar.current
        components = calendar.dateComponents([.day, .month, .year], from: Date())
    }
    
    private func convertTimestampToDate(document: QueryDocumentSnapshot) -> Event {
        var data = document.data()
        if let startTime = data["startTime"] as? Timestamp {
            data.updateValue(startTime.dateValue(), forKey: "startTime")
        }
        if let endTime = data["endTime"] as? Timestamp {
            data.updateValue(endTime.dateValue(), forKey: "endTime")
        }
        if let alertTime = data["alertTime"] as? Timestamp {
            data.updateValue(alertTime.dateValue(), forKey: "alertTime")
        }
        let event = Event(data: data)
        return event
    }
    
    private func getAllEvents(documents: [QueryDocumentSnapshot]) -> [Event] {
        var events: [Event] = []
        for document in documents {
            let event = self.convertTimestampToDate(document: document)
            events.append(event)
        }
        return events
    }
}

// MARK: - Authentication
extension FirebaseService: Authentication {
    func getCurrentUserId() -> String? {
        return auth.currentUser?.uid
    }
    
    func createUser(email: String, password: String, completion: @escaping (Error?) -> Void) {
        auth.createUser(withEmail: email, password: password) { _, error in
            if error != nil,
                let errCode = AuthErrorCode(rawValue: error!._code) {
                switch errCode {
                // if email is already used, then log user in
                case .emailAlreadyInUse:
                    break
                default:
                    completion(error)
                    return
                }
            }
            self.logUserIn(withEmail: email, password: password) { loginError in
                if loginError != nil {
                    completion(loginError)
                    return
                }
                completion(nil)
            }
        }
    }
    
    func logUserIn(withEmail email: String, password: String, completion: @escaping (Error?) -> Void) {
        auth.signIn(withEmail: email, password: password) { (_, error) in
            if error != nil {
                completion(error)
                return
            }
            print("Successfully log user into firebase")
            completion(nil)
        }
    }
    
    func logout() {
        do {
            try auth.signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}

// MARK: - Database
extension FirebaseService: Database {
    func save(event: Event) {
        guard let uid = getCurrentUserId() else { return }
        let eventDictionary = event.getEventDictionary()
        database.collection("users").document(uid).collection("events").addDocument(data: eventDictionary)
    }
    
    func loadTodayEvents(completion: @escaping ([Event]) -> Void) {
        guard
            let uid = getCurrentUserId(),
            let start = calendar.date(from: components),
            let end = calendar.date(byAdding: .day, value: 1, to: start)
            else { return }
        let eventsRef = database.collection("users")
            .document(uid)
            .collection("events")
            .whereField("startTime", isGreaterThan: start)
            .whereField("startTime", isLessThan: end)
        eventsRef.addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(error!)")
                completion([])
                return
            }
            let events = documents.compactMap { (queryDocumentSnapshot) -> Event? in
                return try? queryDocumentSnapshot.data(as: Event.self)
            }
            completion(events)
        }
    }
    
    func loadEvents(from date: Date, completion: @escaping ([EventSection]) -> Void) {
        guard let uid = getCurrentUserId() else { return }
        var eventsInSection: [Event] = []
        var eventSections: [EventSection] = []
        var sectionDate: Date?
        let eventsRef = database.collection("users")
            .document(uid)
            .collection("events")
            .whereField("startTime", isGreaterThan: date)
        eventsRef.addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(error!)")
                completion([])
                return
            }
            let events = documents.compactMap { (queryDocumentSnapshot) -> Event? in
                return try? queryDocumentSnapshot.data(as: Event.self)
            }
            sectionDate = events.first?.startTime
            
            // Filter events that has the same startDate into an eventSection
            for (index, event) in events.enumerated() {
                self.components = self.calendar.dateComponents([.day],
                                                               from: sectionDate ?? Date(),
                                                               to: event.startTime)
                if let dayDifference = self.components.day {
                    if dayDifference > 0 {
                        appendSectionAndEvent(event)
                    } else {
                        eventsInSection.append(event)
                    }
                }
                // append the last eventSection
                if index == events.count - 1 {
                    appendSectionAndEvent(event)
                }
            }
            completion(eventSections)
        }
        
        func appendSectionAndEvent(_ event: Event) {
            sectionDate = event.startTime
            let eventSection = EventSection(events: eventsInSection)
            eventSections.append(eventSection)
            eventsInSection = []
            eventsInSection.append(event)
        }
    }
}
