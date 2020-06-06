//
//  Constants.swift
//  Calendar
//
//  Created by Vy Le on 5/24/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

struct Constants {
    struct AnimationNames {
        static let app = "calendar"
    }
    
    struct Time {
        static let hours = 24
        static let minutesInAHour: Double = 60
    }
    
    struct Date {
        static let maxYear = 2036
        static let minMonth = 1
        static let maxMonth = 12
    }
    
    struct IconNames {
        static let calendar = "calendar"
        static let profile = "person"
        static let add = "plus"
        static let back = "arrow.left"
        static let search = "magnifyingglass"
        static let exit = "xmark"
        static let alarm = "alarm"
        static let repeatName = "repeat"
        static let selectedRadio = "largecircle.fill.circle"
        static let unselectedRadio = "circle"
    }
    
    struct CellId {
        static let dateCellId = "dateCellId"
        static let scheduleCellId = "scheduleCellId"
        static let notificationCellId = "notificationCellId"
        static let sectionHeader = "sectionHeader"
    }
    
    static let setAlertOptions: [AlertOptions] = [
        .minute,
        .hour,
        .day,
        .month
    ]
    
    static let spaceBetweenTimeDivider: CGFloat = 84
}

enum AlertOptions {
    case minute
    case hour
    case day
    case month
}
