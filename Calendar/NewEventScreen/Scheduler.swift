//
//  Scheduler.swift
//  Calendar
//
//  Created by Vy Le on 6/16/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit
import UserNotifications

final class Scheduler {
    // MARK: - Properties
    private let userNotificationCenter = UNUserNotificationCenter.current()
    private let notificationContent = UNMutableNotificationContent()
    
    init() {
        notificationContent.categoryIdentifier = "alarm"
        notificationContent.sound = .default
    }
    
    func checkAuthorizationStatus() {
        userNotificationCenter.getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .notDetermined:
                self.requestNotificationAuthorization()
            default:
                break
            }
        }
    }
    
    func scheduleNotification(for event: Event) {
        // set notification for happening event
        notificationContent.title = event.name
        if let location = event.location {
            notificationContent.subtitle = "Now at \(location)"
        } else {
            notificationContent.subtitle = "Now"
        }
        if let notes = event.notes {
            notificationContent.body = notes
        }
        addNotification(for: event.startTime)
        
        // set notification for upcomming event
        guard let alertTime = event.alertTime else { return }
        let time = getRelativeDateTime(for: event.startTime, relativeTo: alertTime)
        if let location = event.location {
            notificationContent.subtitle = "\(time) at \(location)"
        } else {
            notificationContent.subtitle = "\(time)"
        }
        addNotification(for: alertTime)
    }
    
    private func requestNotificationAuthorization() {
        let authOptions = UNAuthorizationOptions.init(arrayLiteral: .alert, .badge, .sound)
        self.userNotificationCenter.requestAuthorization(options: authOptions) { success, error in
            if success {
                print("All set!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    private func getRelativeDateTime(for expectedDate: Date, relativeTo currentDate: Date) -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.dateTimeStyle = .numeric
        formatter.unitsStyle = .full
        return formatter.localizedString(for: expectedDate, relativeTo: currentDate)
    }
    
    private func addNotification(for date: Date) {
        let dateComponents = Calendar.current.dateComponents(
            [.year, .month, .day, .hour, .minute],
            from: date
        )
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString,
                                            content: notificationContent,
                                            trigger: trigger)
        userNotificationCenter.add(request) { (error) in
            if let error = error {
                print("Notification Error: ", error)
            }
        }
    }
}
