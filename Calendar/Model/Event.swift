//
//  Event.swift
//  Calendar
//
//  Created by Vy Le on 5/27/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit
import Firebase

struct Event: Codable {
    var eventId: String?
    let name: String
    let startTime: Date
    let endTime: Date
    let location: String?
    let notes: String?
    var alertTime: Date?
    var coordinates: GeoPoint?
    
    enum CodingKeys: String, CodingKey {
        case eventId = "id"
        case name
        case startTime
        case endTime
        case location
        case notes
        case alertTime
        case coordinates
    }
    
    init(name: String,
         startTime: Date,
         endTime: Date,
         eventId: String? = nil,
         location: String? = nil,
         notes: String? = nil,
         alertTime: Date? = nil,
         coordinates: GeoPoint? = nil) {
        self.eventId = eventId
        self.name = name
        self.startTime = startTime
        self.endTime = endTime
        self.location = location
        self.notes = notes
        self.alertTime = alertTime
        self.coordinates = coordinates
    }
    
    func getEventDictionary() -> [String: Any] {
        var dictionary: [String: Any] = [
            "name": name,
            "startTime": startTime,
            "endTime": endTime
        ]
        if let eventId = self.eventId {
            dictionary.updateValue(eventId, forKey: "id")
        }
        if let location = self.location {
            dictionary.updateValue(location, forKey: "location")
        }
        if let notes = self.notes {
            dictionary.updateValue(notes, forKey: "notes")
        }
        if let alertTime = self.alertTime {
            dictionary.updateValue(alertTime, forKey: "alertTime")
        }
        if let coordinates = self.coordinates {
            dictionary.updateValue(coordinates, forKey: "coordinates")
        }
        return dictionary
    }
}
