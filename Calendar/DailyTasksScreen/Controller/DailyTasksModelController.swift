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
    }

    func loadEvents(completion: @escaping () -> Void) {
        database.loadEventsForToday { events in
            self.events = events
            completion()
        }
    }

    // MARK: - Getters
    func getEvents() -> [Event] {
        return events
    }
}
