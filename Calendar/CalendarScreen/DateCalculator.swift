//
//  DateCalculator.swift
//  Calendar
//
//  Created by Vy Le on 5/28/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

final class DateCalculator {
    private var date: Date
    private let calendar: Calendar
    private var year: Int
    private var month: Int
    private var dates: [Date]
    private var converter: DateConverter
    
    init(date: Date) {
        self.date = date
        self.calendar = Calendar.current
        self.converter = DateConverter()
        converter.convert(date: date)
        self.month = converter.getMonth()
        self.year = converter.getYear()
        self.dates = [Date]()
        checkValidDate()
    }
    
    func calculateDate(at index: Int) -> Date {
        if dates.count < index {
            return Date()
        }
        return dates[index]
    }
    
    func getDayString(at index: Int) -> String {
        if dates.count < index {
            return "N/A"
        }
        return converter.getDay(from: dates[index])
    }
    
    func isInCurrentMonth(at index: Int) -> Bool {
        if dates.count > index {
            converter.convert(date: dates[index])
            if converter.getMonth() == self.month {
                return true
            }
        }
        return false
    }
    
    func isSelectedDate(at index: Int) -> Bool {
        if dates.count < index {
            return false
        }
        let selectedComponents = calendar.dateComponents([.day, .month, .year], from: date)
        let dateComponents = calendar.dateComponents([.day, .month, .year], from: dates[index])
        if selectedComponents == dateComponents {
            return true
        } else {
           return false
        }
    }
    
    func getDateFrom(day: Int, month: Int, year: Int) -> Date {
        let dateComponents = DateComponents(
            year: year,
            month: month,
            day: day
        )
        return Calendar.current.date(from: dateComponents) ?? Date()
    }
    
    private func checkValidDate() {
        if month > Constants.Date.maxMonth && year > Constants.Date.maxYear {
            let date = Date()
            converter.convert(date: date)
            self.month = converter.getMonth()
            self.year = converter.getYear()
        }
        getMonthlyCalendar()
    }
    
    private func getMonthlyCalendar() {
        let space = calculateSpaceNeededFromLastMonth()
        let numOfdaysOfLastMonth = getNumOfDaysInMonth(month - 1)
        let numOfDaysThisMonth = getNumOfDaysInMonth(month)
        var lastMonth = month - 1
        var nextMonth = month + 1
        if month - 1 > Constants.Date.maxMonth {
            lastMonth = 12
        }
        if month + 1 > Constants.Date.maxYear {
            nextMonth = 1
        }
        
        // last month
        for index in 1...space {
            let day = numOfdaysOfLastMonth - (space - index)
            let date = getDateFrom(day: day, month: lastMonth, year: year)
            dates.append(date)
        }
        // this month
        for day in 1...numOfDaysThisMonth {
            let date = getDateFrom(day: day, month: month, year: year)
            dates.append(date)
        }
        // next month
        for day in 1...(42 - numOfDaysThisMonth - space) {
            let date = getDateFrom(day: day, month: nextMonth, year: year)
            dates.append(date)
        }
    }
    
    private func calculateSpaceNeededFromLastMonth() -> Int {
        guard let weekday = getWeekdayOfDayOne(month: month) else { return 0 }
        return weekday - 1
    }
    
    private func getWeekdayOfDayOne(month: Int) -> Int? {
        let dateComponents = DateComponents(
            year: year,
            month: month,
            day: 1
        )
        let date = Calendar.current.date(from: dateComponents) ?? Date()
        return calendar.dateComponents([.weekday], from: date).weekday
    }
    
    private func getNumOfDaysInMonth(_ month: Int) -> Int {
        let dateComponents = DateComponents(year: year, month: month)
        guard
            let date = calendar.date(from: dateComponents),
            let range = calendar.range(of: .day, in: .month, for: date)
            else { return 0 }
        let numDays = range.count
        return numDays
    }
}
