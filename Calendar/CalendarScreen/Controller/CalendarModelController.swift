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
    private var sections: [EventSection]

    // MARK: - Initializer
    init(database: Database = FirebaseService.shared) {
        self.database = database
        self.events = [Event]()
        self.sections = [EventSection]()
    }

    func loadEvents(completion: @escaping () -> Void) {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day, .month, .year], from: Date())
        guard let date = calendar.date(from: components) else {
            completion()
            return
        }
        database.loadEvents(from: date) { sections in
            self.sections = sections
            completion()
        }
    }

    // MARK: - Getters
    func getEvents(at sectionIndex: Int) -> [Event] {
        return sections[sectionIndex].events
    }
    
    func getSections() -> [EventSection] {
        return sections
    }
}
