//
//  CalendarModelController.swift
//  Calendar
//
//  Created by Vy Le on 6/10/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

final class CalendarModelController {
    // MARK: - Properties
    private let database: Database
    private var events: [Event]

    // MARK: - Initializer
    init(database: Database = FirebaseService.shared) {
        self.database = database
        self.events = [Event]()
    }

    func loadEvents(completion: @escaping () -> Void) {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day, .month, .year], from: Date())
        guard let date = calendar.date(from: components) else {
            completion()
            return
        }
        database.loadEvents(from: date) { events in
            self.events = events
            completion()
        }
    }

    // MARK: - Getters
    func getEvents() -> [Event] {
        return events
    }
    
}
