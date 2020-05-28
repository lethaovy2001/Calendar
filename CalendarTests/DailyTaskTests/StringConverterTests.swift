//
//  StringConverterTests.swift
//  CalendarTests
//
//  Created by Vy Le on 5/28/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import XCTest
@testable import Calendar

class StringConverterTests: XCTestCase {
    var stringConverter: StringConverter!
    
    override func setUp() {
        super.setUp()
        stringConverter = StringConverter()
    }
    
    func testConversionForOneHour() {
        // Given
        let hour = 1
        
        // When
        let result = stringConverter.convert(hour)
        
        // Then
        XCTAssertEqual(result, "01:00")
    }
    
    func testConversionForNineHour() {
        // Given
        let hour = 9
        
        // When
        let result = stringConverter.convert(hour)
        
        // Then
        XCTAssertEqual(result, "09:00")
    }
    
    func testConversionForTenHour() {
        // Given
        let hour = 10
        
        // When
        let result = stringConverter.convert(hour)
        
        // Then
        XCTAssertEqual(result, "10:00")
    }
    
    func testConversionForTwentyFourHour() {
        // Given
        let hour = 24
        
        // When
        let result = stringConverter.convert(hour)
        
        // Then
        XCTAssertEqual(result, "24:00")
    }
}
