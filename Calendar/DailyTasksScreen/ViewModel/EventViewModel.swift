//
//  EventViewModel.swift
//  Calendar
//
//  Created by Vy Le on 6/10/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

final class EventViewModel {
    private var model: Event
    private var dateFormatter: DateFormatter
    
    init(model: Event) {
        self.model = model
        self.dateFormatter = DateFormatter()
        self.dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    }
}

extension EventViewModel {
    var name: String {
        return model.name
    }
    
    var startTimeDate: String {
        self.dateFormatter.dateFormat = "h:mm a MMM dd, yyyy"
        return dateFormatter.string(from: model.startTime)
    }
    
    var endTimeDate: String {
        self.dateFormatter.dateFormat = "h:mm a MMM dd, yyyy"
        return dateFormatter.string(from: model.endTime)
    }
    
    var startTime: String {
        self.dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: model.startTime)
    }
    
    var endTime: String {
        self.dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: model.endTime)
    }
    
    var startDate: String {
        self.dateFormatter.dateFormat = "EEEE, MMM, dd, yyyy"
        return dateFormatter.string(from: model.startTime)
    }
    
    var location: String? {
        guard model.location != "" else { return nil }
        return model.location
    }
    
    var notes: String? {
        return model.notes
    }
    
    var alertTime: String? {
        guard let alertTime = model.alertTime else { return nil }
        let difference = Calendar.current.dateComponents([.minute, .hour, .day, .weekOfYear],
                                                         from: alertTime,
                                                         to: model.startTime)
        guard
            let minute = difference.minute,
            let hour = difference.hour,
            let day = difference.day,
            let week = difference.weekOfYear
        else { return nil }
        if week != 0 {
            guard week > 1 else { return "\(week) weeks before" }
            return "\(week) week before"
        } else if day != 0 {
            guard day > 1 else { return "\(day) days before" }
            return "\(day) day before"
        } else if hour != 0 {
            guard hour > 1 else { return "\(hour) hours before" }
            return "\(hour) hour before"
        } else if minute != 0 {
            guard minute > 1 else { return "\(minute) minutes before" }
            return "\(minute) minute before"
        }
        return nil
    }
}
