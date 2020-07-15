//
//  Notification+Extension.swift
//  Calendar
//
//  Created by Vy Le on 7/15/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

extension Notification.Name {
    static var deleteEvent: Notification.Name {
        return .init(rawValue: "EventDetailsViewController.deleteEvent")
    }
}
