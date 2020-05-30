//
//  DateConverter.swift
//  Calendar
//
//  Created by Vy Le on 5/30/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

final class DateConverter {
    private let date: Date
    private let calendar: Calendar
    private var weekday: Int?
    private var day: Int?
    private var month: Int?
    private var year: Int?
    
    init(date: Date) {
        self.date = date
        self.calendar = Calendar.current
        convert()
    }
    
    private func convert() {
        let components = calendar.dateComponents([.weekday, .day, .month, .year], from: date)
        self.weekday = components.weekday
        self.day = components.day
        self.month = components.month
        self.year = components.year
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
