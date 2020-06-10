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
            if error != nil {
                completion(error)
                return
            }
            self.logUserIn(withEmail: email, password: password) { loginError in
                if let loginError = loginError {
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
            let events = self.getAllEvents(documents: documents)
            completion(events)
        }
    }
    
    func loadEvents(from date: Date, completion: @escaping ([EventSection]) -> Void) {
        guard let uid = getCurrentUserId() else { return }
        var eventsInSection: [Event] = []
        var sections: [EventSection] = []
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
            for (index, document) in documents.enumerated() {
                let event = self.convertTimestampToDate(document: document)
                if sectionDate == nil {
                    sectionDate = event.startTime
                }
                self.components = self.calendar.dateComponents([.day],
                                                     from: sectionDate ?? Date(),
                                                     to: event.startTime)
                if let day = self.components.day {
                    // if the sectionDate is different than the startDate of the event
                    //      then append section and reset values
                    // else append events into the current section
                    if day > 0 {
                        appendSection(event: event)
                    } else {
                        eventsInSection.append(event)
                    }
                }
                if index == documents.count - 1 {
                    appendSection(event: event)
                }
            }
            completion(sections)
        }
        
        func appendSection(event: Event) {
            sectionDate = event.startTime
            let eventSection = EventSection(events: eventsInSection)
            sections.append(eventSection)
            eventsInSection = []
            eventsInSection.append(event)
        }
    }
}
