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
    var counter: DateCounter!

    override func setUp() {
        super.setUp()
        counter = DateCounter(month: 5, year: 2020)
    }
    
    func testCalculateDate() {
        // Given
        let date0 = counter.getDateFrom(day: 26, month: 4, year: 2020)
        let date1 = counter.getDateFrom(day: 1, month: 5, year: 2020)
        let date2 = counter.getDateFrom(day: 6, month: 6, year: 2020)
        
        let index0 = 0
        let index1 = 5
        let index2 = 41
        
        // When
        let result0 = counter.getDate(at: index0)
        let result1 = counter.getDate(at: index1)
        let result2 = counter.getDate(at: index2)
        
        // Then
        XCTAssertEqual(result0, date0)
        XCTAssertEqual(result1, date1)
        XCTAssertEqual(result2, date2)
    }
}
