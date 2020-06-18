//
//  Event.swift
//  Calendar
//
//  Created by Vy Le on 5/27/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

struct Event: Codable {
    let eventId: String
    let name: String
    let startTime: Date
    let endTime: Date
    let location: String?
    let notes: String?
    var alertTime: Date?
    
    enum CodingKeys: String, CodingKey {
        case eventId = "id"
        case name
        case startTime
        case endTime
        case location
        case notes
        case alertTime
    }
    
    init(name: String,
         startTime: Date,
         endTime: Date,
         eventId: String? = nil,
         location: String? = nil,
         notes: String? = nil,
         alertTime: Date? = nil) {
        self.eventId = UUID().uuidString
        self.name = name
        self.startTime = startTime
        self.endTime = endTime
        self.location = location
        self.notes = notes
        self.alertTime = alertTime
    }
    
    init(data: [String: Any]) {
        self.eventId = data["id"] as? String ?? UUID().uuidString
        self.name = data["name"] as? String ?? "Event"
        self.alertTime = data["alertTime"] as? Date
        self.location = data["location"] as? String
        self.notes = data["notes"] as? String
        if let startTime = data["startTime"] as? Date,
            let endTime = data["endTime"] as? Date {
            self.startTime = startTime
            self.endTime = endTime
        } else {
            self.startTime = Date()
            self.endTime = Date(timeInterval: 3600, since: startTime)
        }
    }
    
    func getEventDictionary() -> [String: Any] {
        var dictionary: [String: Any] = [
            "id": eventId,
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
