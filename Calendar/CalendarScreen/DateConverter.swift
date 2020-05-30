//
//  DateConverter.swift
//  Calendar
//
//  Created by Vy Le on 5/30/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

final class DateConverter {
    private let calendar: Calendar
    private var weekday: Int?
    private var day: Int?
    private var month: Int?
    private var year: Int?
    
    init() {
        self.calendar = Calendar.current
    }
    
    func convert(date: Date) {
        let components = calendar.dateComponents([.weekday, .day, .month, .year], from: date)
        self.weekday = components.weekday
        self.day = components.day
        self.month = components.month
        self.year = components.year
    }
    
    func getMonthName(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        let nameOfMonth = dateFormatter.string(from: date)
        return nameOfMonth
    }
    
    func getDay(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        let day = dateFormatter.string(from: date)
        return day
    }
    
    func getWeekday() -> Int {
        return weekday ?? 0
    }
    
    func getDay() -> Int {
        return day ?? 0
    }
    
    func getMonth() -> Int {
        return month ?? 0
    }
    
    func getYear() -> Int {
        return year ?? 0
    }
}
