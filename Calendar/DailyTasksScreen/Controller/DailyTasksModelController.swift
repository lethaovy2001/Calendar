//
//  DailyTasksModelController.swift
//  Calendar
//
//  Created by Vy Le on 6/6/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

final class DailyTasksModelController {
    // MARK: - Properties
    private let database: Database
    private var events: [Event]

    // MARK: - Initializer
    init(database: Database = FirebaseService.shared) {
        self.database = database
        self.events = [Event]()
        loadMockEvents()
    }

    // MARK: - Getters
    func loadMockEvents() {
        var components = DateComponents()
        components.hour = 4
        components.minute = 30
        var start = Calendar.current.date(from: components) ?? Date()
        components.hour = 6
        components.minute = 0
        var end = Calendar.current.date(from: components) ?? Date()
        var event = Event(name: "Morning Exercise", startTime: start, endTime: end, location: "Social Science")
        events.append(event)

        components.hour = 2
        components.minute = 30
        start = Calendar.current.date(from: components) ?? Date()
        components.hour = 3
        components.minute = 0
        end = Calendar.current.date(from: components) ?? Date()
        event = Event(name: "Yoga Class", startTime: start, endTime: end, location: "Gym")
        events.append(event)

        components.hour = 7
        components.minute = 45
        start = Calendar.current.date(from: components) ?? Date()
        components.hour = 8
        components.minute = 30
        end = Calendar.current.date(from: components) ?? Date()
        event = Event(name: "Study Group", startTime: start, endTime: end, location: "Library")
        events.append(event)

        components.hour = 10
        components.minute = 15
        start = Calendar.current.date(from: components) ?? Date()
        components.hour = 10
        components.minute = 30
        end = Calendar.current.date(from: components) ?? Date()
        event = Event(name: "Meditate", startTime: start, endTime: end, location: "Home")
        events.append(event)
    }

    func getEvents() -> [Event] {
        return events
    }
}
