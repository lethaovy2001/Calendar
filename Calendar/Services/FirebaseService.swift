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
                if index == documents.count - 1 {
                    appendSectionAndEvent(event)
                }
            }
            completion(sections)
        }
        
        func appendSectionAndEvent(_ event: Event) {
            sectionDate = event.startTime
            let eventSection = EventSection(events: eventsInSection)
            sections.append(eventSection)
            eventsInSection = []
            eventsInSection.append(event)
        }
    }
}
