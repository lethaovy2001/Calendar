//
//  EventLayoutGenerator.swift
//  Calendar
//
//  Created by Vy Le on 5/27/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

struct EventLayoutGenerator {
    func estimateHeight(event: Event) -> CGFloat {
        let startComponents = Calendar.current.dateComponents([.hour, .minute], from: event.startTime)
        let startHour = CGFloat(startComponents.hour ?? 0)
        let startMinute = CGFloat(startComponents.minute ?? 0)/60.0
        let endComponents = Calendar.current.dateComponents([.hour, .minute], from: event.endTime)
        let endHour = CGFloat(endComponents.hour ?? 0)
        let endMinute = CGFloat(endComponents.minute ?? 0)/60.0
        let timeInHour = endHour - startHour + endMinute -  startMinute
        return timeInHour * Constants.spaceBetweenTimeDivider
    }
    
    func estimateTopOffset(of date: Date) -> CGFloat {
        let startComponents = Calendar.current.dateComponents([.hour, .minute], from: date)
        let hour = CGFloat(startComponents.hour ?? 0)
        let minute = CGFloat(startComponents.minute ?? 0)/60.0
        return (hour + minute) * Constants.spaceBetweenTimeDivider + 10
    }
}

