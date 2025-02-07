//
//  DateCounter.swift
//  Calendar
//
//  Created by Vy Le on 5/28/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class DateCounter {
    private let calendar: Calendar
    private var year: Int
    private var month: Int
    private var dates = [Date]()

    init(month: Int, year: Int) {
        calendar = Calendar.current
        self.month = month
        self.year = year
        checkValidDate()
    }

    func set(month: Int, year: Int) {
        self.month = month
        self.year = year
        checkValidDate()
    }

    func getDate(at calendarDateIndex: Int) -> Date {
        if dates.count < calendarDateIndex {
            return Date()
        }
        return dates[calendarDateIndex]
    }

    func getDayString(at calendarDateIndex: Int) -> String {
        if dates.count < calendarDateIndex {
            return "N/A"
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        let day = dateFormatter.string(from: dates[calendarDateIndex])
        return day
    }

    func isNotInCurrentMonth(at index: Int) -> Bool {
        if dates.count > index {
            let dateComponents = Calendar.current.dateComponents([.month], from: dates[index])
            guard let month = dateComponents.month else { return false }
            if month == self.month {
                return false
            }
        }
        return true
    }

    func isTodayDate(at index: Int) -> Bool {
        if dates.count < index {
            return false
        }
        let today = Date()
        let todayComponents = calendar.dateComponents([.day, .month, .year], from: today)
        let dateComponents = calendar.dateComponents([.day, .month, .year], from: dates[index])
        if todayComponents == dateComponents {
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
            let components = calendar.dateComponents([.month, .year], from: date)
            guard
                let month = components.month,
                let year = components.year
            else { return }
            self.month = month
            self.year = year
        }
        addAllTheDatesInAMonth()
    }

    private func addAllTheDatesInAMonth() {
        let numOfLeftOverDatesFromLastMonth = calculateLeftOverDatesFromLastMonth()
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
        for index in 1...numOfLeftOverDatesFromLastMonth {
            let day = numOfdaysOfLastMonth - (numOfLeftOverDatesFromLastMonth - index)
            let date = getDateFrom(day: day, month: lastMonth, year: year)
            dates.append(date)
        }
        // this month
        for day in 1...numOfDaysThisMonth {
            let date = getDateFrom(day: day, month: month, year: year)
            dates.append(date)
        }
        // next month
        for day in 1...(42 - numOfDaysThisMonth - numOfLeftOverDatesFromLastMonth) {
            let date = getDateFrom(day: day, month: nextMonth, year: year)
            dates.append(date)
        }
    }

    private func calculateLeftOverDatesFromLastMonth() -> Int {
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
