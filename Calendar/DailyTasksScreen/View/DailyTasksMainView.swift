//
//  DailyTasksMainView.swift
//  Calendar
//
//  Created by Vy Le on 5/25/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

final class DailyTasksMainView : UIView {
    // MARK: - Properties
    private let scrollView = CustomScrollView()
    private let headerLabel = CustomLabel(text: "Daily Tasks", textColor: AppColor.darkGray, textSize: 36, textWeight: .heavy)
    private let timeLine = RunningTimeLineView()
    
    // MARK: - Initializer
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setup() {
        setupSelf()
        addSubviews()
        setupConstraints()
        addTimeLine()
        getMockEvents()
        setupTimeLineConstraints()
    }
    
    // TODO: Remove this function
    private func getMockEvents() {
        var components = DateComponents()
        components.hour = 4
        components.minute = 30
        var start = Calendar.current.date(from: components) ?? Date()
        components.hour = 6
        components.minute = 0
        var end = Calendar.current.date(from: components) ?? Date()
        var event = Event(name: "Morning Exercise", startTime: start, endTime: end, location: "Social Science")
        setEvent(event: event)
        
        components.hour = 2
        components.minute = 30
        start = Calendar.current.date(from: components) ?? Date()
        components.hour = 3
        components.minute = 0
        end = Calendar.current.date(from: components) ?? Date()
        event = Event(name: "Yoga Class", startTime: start, endTime: end, location: "Gym")
        setEvent(event: event)
        
        components.hour = 7
        components.minute = 45
        start = Calendar.current.date(from: components) ?? Date()
        components.hour = 8
        components.minute = 30
        end = Calendar.current.date(from: components) ?? Date()
        event = Event(name: "Study Group", startTime: start, endTime: end, location: "Library")
        setEvent(event: event)
        
        components.hour = 10
        components.minute = 15
        start = Calendar.current.date(from: components) ?? Date()
        components.hour = 10
        components.minute = 30
        end = Calendar.current.date(from: components) ?? Date()
        event = Event(name: "Meditate", startTime: start, endTime: end, location: "Home")
        setEvent(event: event)
    }
    
    private func setupSelf() {
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func addSubviews() {
        addSubview(headerLabel)
        addSubview(scrollView)
        scrollView.addSubview(timeLine)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 80),
            headerLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 36),
        ])
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor, constant: 160),
            scrollView.leftAnchor.constraint(equalTo: self.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: self.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    private func setupTimeLineConstraints() {
        let date = Date()
        let offset = estimateTopOffset(of: date)
        NSLayoutConstraint.activate([
            timeLine.heightAnchor.constraint(equalToConstant: 10),
            timeLine.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: offset),
            timeLine.rightAnchor.constraint(equalTo: rightAnchor),
            timeLine.leftAnchor.constraint(equalTo: leftAnchor, constant: 84)
        ])
    }
    
    private func addTimeLine() {
        for hour in 0...Constants.Time.hours {
            let divider = TimeDividerView(time: hour)
            let topOffset = Constants.spaceBetweenTimeDivider * CGFloat(hour)
            scrollView.addSubview(divider)
            NSLayoutConstraint.activate([
                divider.heightAnchor.constraint(equalToConstant: 20),
                divider.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: topOffset),
                divider.rightAnchor.constraint(equalTo: rightAnchor),
                divider.leftAnchor.constraint(equalTo: leftAnchor, constant: 24)
            ])
            if hour == Constants.Time.hours {
                NSLayoutConstraint.activate([
                    divider.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -60)
                ])
            }
        }
    }
    
    private func setEvent(event: Event) {
        let height = estimateEventHeight(event: event)
        let offset = estimateTopOffset(of: event.startTime)
        let eventView = EventView(height: height)
        scrollView.addSubview(eventView)
        NSLayoutConstraint.activate([
            eventView.heightAnchor.constraint(equalToConstant: height),
            eventView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: offset),
            eventView.rightAnchor.constraint(equalTo: rightAnchor, constant: -24),
            eventView.leftAnchor.constraint(equalTo: leftAnchor, constant: 106),
        ])
    }
    
    //TODO: write unit test
    private func estimateEventHeight(event: Event) -> CGFloat {
        let startComponents = Calendar.current.dateComponents([.hour, .minute], from: event.startTime)
        let startHour = CGFloat(startComponents.hour ?? 0)
        let startMinute = CGFloat(startComponents.minute ?? 0)/60.0
        let endComponents = Calendar.current.dateComponents([.hour, .minute], from: event.endTime)
        let endHour = CGFloat(endComponents.hour ?? 0)
        let endMinute = CGFloat(endComponents.minute ?? 0)/60.0
        let timeInHour = endHour - startHour + endMinute -  startMinute
        return timeInHour * Constants.spaceBetweenTimeDivider
    }
    
    //TODO: write unit test
    private func estimateTopOffset(of date: Date) -> CGFloat {
        let startComponents = Calendar.current.dateComponents([.hour, .minute], from: date)
        let hour = CGFloat(startComponents.hour ?? 0)
        let minute = CGFloat(startComponents.minute ?? 0)/60.0
        return (hour + minute) * Constants.spaceBetweenTimeDivider + 10
    }
}

struct Event {
    let name: String
    let startTime: Date
    let endTime: Date
    let location: String?
}

