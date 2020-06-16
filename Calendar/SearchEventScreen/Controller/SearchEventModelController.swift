//
//  SearchEventModelController.swift
//  Calendar
//
//  Created by Vy Le on 6/16/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

final class SearchEventModelController {
    // MARK: - Properties
    private let database: Database
    private var events: [Event]

    // MARK: - Initializer
    init(database: Database = FirebaseService.shared) {
        self.database = database
        self.events = [Event]()
        loadEvents()
    }

    func loadEvents() {
        database.loadAllEvents { events in
            self.events = events
        }
    }
    
    func filterEvents(contains name: String) {
        let filterEvents = events.filter { $0.name.contains(name) }
        self.events = filterEvents
    }

    // MARK: - Getters
    func getEvents() -> [Event] {
        return events
    }
}
