//
//  DateCounterTests.swift
//  CalendarTests
//
//  Created by Vy Le on 5/28/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import XCTest
@testable import Calendar

class DateCounterTests: XCTestCase {
    var calculator: DateCounter!

    override func setUp() {
        super.setUp()
        calculator = DateCounter(month: 5, year: 2020)
    }
    
    func testCalculateDate() {
        // Given
        let date0 = calculator.getDateFrom(day: 26, month: 4, year: 2020)
        let date1 = calculator.getDateFrom(day: 1, month: 5, year: 2020)
        let date2 = calculator.getDateFrom(day: 6, month: 6, year: 2020)
        
        let index0 = 0
        let index1 = 5
        let index2 = 41
        
        // When
        let result0 = calculator.getDate(at: index0)
        let result1 = calculator.getDate(at: index1)
        let result2 = calculator.getDate(at: index2)
        
        // Then
        XCTAssertEqual(result0, date0)
        XCTAssertEqual(result1, date1)
        XCTAssertEqual(result2, date2)
    }
}


