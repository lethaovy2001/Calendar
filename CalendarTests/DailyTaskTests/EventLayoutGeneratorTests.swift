//
//  EventLayoutGeneratorTests.swift
//  CalendarTests
//
//  Created by Vy Le on 5/27/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import XCTest
@testable import Calendar

class EventLayoutGeneratorTests: XCTestCase {
    let layoutGenerator = EventLayoutGenerator()
    var components: DateComponents!
    
    override func setUp() {
        super.setUp()
        components = DateComponents()
    }
    
    func testEstimateHeightForOneHour() {
        // Given
        components.hour = 0
        components.minute = 00
        let start = Calendar.current.date(from: components) ?? Date()
        components.hour = 1
        components.minute = 00
        let end = Calendar.current.date(from: components) ?? Date()
        let event = Event(name: "Event Title", startTime: start, endTime: end, location: "Location")
        
        // When
        let height = layoutGenerator.estimateHeight(event: event)
        
        // Then
        XCTAssertEqual(height, 84)
    }
    
    func testEstimateHeightForFourtyFiveMins() {
        // Given
        components.hour = 0
        components.minute = 00
        let start = Calendar.current.date(from: components) ?? Date()
        components.hour = 0
        components.minute = 45
        let end = Calendar.current.date(from: components) ?? Date()
        let event = Event(name: "Event Title", startTime: start, endTime: end, location: "Location")
        
        // When
        let height = layoutGenerator.estimateHeight(event: event)
        
        // Then
        XCTAssertEqual(height, 63)
    }
    
    func testEstimateHeightForThirtyMins() {
        // Given
        components.hour = 0
        components.minute = 00
        let start = Calendar.current.date(from: components) ?? Date()
        components.hour = 0
        components.minute = 30
        let end = Calendar.current.date(from: components) ?? Date()
        let event = Event(name: "Event Title", startTime: start, endTime: end, location: "Location")
        
        // When
        let height = layoutGenerator.estimateHeight(event: event)
        
        // Then
        XCTAssertEqual(height, 42)
    }
    
    func testEstimateHeightForFifteenMins() {
        // Given
        components.hour = 0
        components.minute = 00
        let start = Calendar.current.date(from: components) ?? Date()
        components.hour = 0
        components.minute = 15
        let end = Calendar.current.date(from: components) ?? Date()
        let event = Event(name: "Event Title", startTime: start, endTime: end, location: "Location")
        
        // When
        let height = layoutGenerator.estimateHeight(event: event)
        
        // Then
        XCTAssertEqual(height, 21)
    }
    
    func testEstimateHeightForOneHourAndThirtyMins() {
        // Given
        components.hour = 0
        components.minute = 00
        let start = Calendar.current.date(from: components) ?? Date()
        components.hour = 1
        components.minute = 30
        let end = Calendar.current.date(from: components) ?? Date()
        let event = Event(name: "Event Title", startTime: start, endTime: end, location: "Location")
        
        // When
        let height = layoutGenerator.estimateHeight(event: event)
        
        // Then
        XCTAssertEqual(height, 126)
    }
    
    func testEstimateHeightForTwoHours() {
        // Given
        components.hour = 0
        components.minute = 00
        let start = Calendar.current.date(from: components) ?? Date()
        components.hour = 2
        components.minute = 00
        let end = Calendar.current.date(from: components) ?? Date()
        let event = Event(name: "Event Title", startTime: start, endTime: end, location: "Location")
        
        // When
        let height = layoutGenerator.estimateHeight(event: event)
        
        // Then
        XCTAssertEqual(height, 168)
    }
    
    func testEstimateTopOffsetForTwelveAM() {
        // Given
        components.hour = 00
        components.minute = 00
        let date = Calendar.current.date(from: components) ?? Date()
        
        // When
        let offset = layoutGenerator.estimateTopOffset(of: date)
        
        // Then
        XCTAssertEqual(offset, 10)
    }
    
    func testEstimateTopOffsetForSixAM() {
        // Given
        components.hour = 06
        components.minute = 00
        let date = Calendar.current.date(from: components) ?? Date()
        
        // When
        let offset = layoutGenerator.estimateTopOffset(of: date)
        
        // Then
        XCTAssertEqual(offset, 514)
    }
    
    func testEstimateTopOffsetForTwelvePM() {
        // Given
        components.hour = 12
        components.minute = 00
        let date = Calendar.current.date(from: components) ?? Date()
        
        // When
        let offset = layoutGenerator.estimateTopOffset(of: date)
        
        // Then
        XCTAssertEqual(offset, 1018)
    }
    
    func testEstimateTopOffsetForSixPM() {
        // Given
        components.hour = 16
        components.minute = 00
        let date = Calendar.current.date(from: components) ?? Date()
        
        // When
        let offset = layoutGenerator.estimateTopOffset(of: date)
        
        // Then
        XCTAssertEqual(offset, 1354)
    }
    
}
