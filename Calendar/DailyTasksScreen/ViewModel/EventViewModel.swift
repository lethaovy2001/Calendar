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
        self.dateFormatter.dateFormat = "h:mm a MMM dd, yyyy"
        self.dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    }
}

extension EventViewModel {
    var name: String {
        return model.name
    }
    
    var startTime: String {
        return dateFormatter.string(from: model.startTime)
    }
    
    var endTime: String {
        return dateFormatter.string(from: model.endTime)
    }
    
    var location: String? {
        guard model.location != "" else { return nil }
        return model.location
    }
}
