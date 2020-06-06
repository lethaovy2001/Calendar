//
//  Event.swift
//  Calendar
//
//  Created by Vy Le on 5/27/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

struct Event {
    let name: String
    let startTime: Date
    let endTime: Date
    let location: String?
    let notes: String?
    var alertTime: Date?
    
    init(name: String,
         startTime: Date,
         endTime: Date,
         location: String? = nil,
         notes: String? = nil,
         alertTime: Date? = nil) {
        self.name = name
        self.startTime = startTime
        self.endTime = endTime
        self.location = location
        self.notes = notes
        self.alertTime = alertTime
    }
    
    func getEventDictionary() -> [String: Any] {
        var dictionary: [String: Any] = [
            "name": name,
            "startTime": startTime,
            "endTime": endTime
        ]
        if let location = self.location {
            dictionary.updateValue(location, forKey: "location")
        }
        if let notes = self.notes {
            dictionary.updateValue(notes, forKey: "notes")
        }
        if let alertTime = self.alertTime {
            dictionary.updateValue(alertTime, forKey: "alertTime")
        }
        return dictionary
    }
}
