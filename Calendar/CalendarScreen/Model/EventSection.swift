//
//  EventSection.swift
//  Calendar
//
//  Created by Vy Le on 6/10/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

struct EventSection {
    let date: Date?
    let events: [Event]
    
    init(events: [Event], date: Date? = nil) {
        self.events = events
        self.date = events.first?.startTime
    }
}
