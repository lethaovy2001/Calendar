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
    private let dateFormatter: DateFormatter
    private var weekday: Int?
    private var day: Int?
    private var month: Int?
    private var year: Int?
    
    init() {
        self.calendar = Calendar.current
        self.dateFormatter = DateFormatter()
    }
    
    func convert(date: Date) {
        let components = calendar.dateComponents([.weekday, .day, .month, .year], from: date)
        self.weekday = components.weekday
        self.day = components.day
        self.month = components.month
        self.year = components.year
    }
    
    func convertToDate(from text: String) -> Date? {
        dateFormatter.dateFormat = "HH:mm a MMM dd, yyyy"
        return dateFormatter.date(from: text)
    }
    
    func getDateString(from date: Date) -> String {
        dateFormatter.dateFormat = "HH:mm a MMM dd, yyyy"
        return dateFormatter.string(from: date)
    }
    
    func getMonthName(from date: Date) -> String {
        dateFormatter.dateFormat = "LLLL"
        return dateFormatter.string(from: date)
    }
    
    func getDay(from date: Date) -> String {
        dateFormatter.dateFormat = "d"
        return dateFormatter.string(from: date)
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
