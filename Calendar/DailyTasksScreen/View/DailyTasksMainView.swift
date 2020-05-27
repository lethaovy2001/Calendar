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
    private let headerLabel = CustomLabel(text: "Daily Tasks", textColor: .darkGray, textSize: 36, textWeight: .heavy)
    
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
        addSubViews()
        setupConstraints()
        addTimeLine()
        
        var components = DateComponents()
        components.hour = 4
        components.minute = 30
        let start = Calendar.current.date(from: components) ?? Date()
        
        components = DateComponents()
        components.hour = 6
        components.minute = 0
        let end = Calendar.current.date(from: components) ?? Date()
        
        let event = Event(name: "Morning Exercise", startTime: start, endTime: end, location: "Social Science")
        setEvent(event: event)
        
    }
    
    
    private func setupSelf() {
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func addSubViews() {
        addSubview(headerLabel)
        addSubview(scrollView)
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
    
    private func addTimeLine() {
        for hour in 0...Constants.Time.hours {
            let timeLine = TimeLineView(time: hour)
            scrollView.addSubview(timeLine)
            NSLayoutConstraint.activate([
                timeLine.heightAnchor.constraint(equalToConstant: 20),
                timeLine.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: CGFloat(84 * hour)),
                timeLine.rightAnchor.constraint(equalTo: rightAnchor),
                timeLine.leftAnchor.constraint(equalTo: leftAnchor, constant: 24),
            ])
            if hour == Constants.Time.hours {
                NSLayoutConstraint.activate([
                    timeLine.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -60),
                ])
            }
        }
    }
    
    //TODO: write unit test
    private func setEvent(event: Event) {
        let startComponents = Calendar.current.dateComponents([.hour, .minute], from: event.startTime)
        let hour = startComponents.hour ?? 0
        let minute = startComponents.minute ?? 0
        let convertedStartMinute = CGFloat(minute)/60.0
        
        let endComponents = Calendar.current.dateComponents([.hour, .minute], from: event.endTime)
        let endHour = endComponents.hour ?? 0
        let endMinute = endComponents.minute ?? 0
        let convertedMinute = CGFloat(endMinute)/60.0
        let hourDifferences = hour.distance(to: endHour)
        let height: CGFloat = CGFloat(hourDifferences) +  convertedMinute - convertedStartMinute
        
        let eventView = EventView(height: height)
        scrollView.addSubview(eventView)
        NSLayoutConstraint.activate([
            eventView.heightAnchor.constraint(equalToConstant: height * 84),
            eventView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: CGFloat(84 * hour + 10) + convertedStartMinute * 84),
            eventView.rightAnchor.constraint(equalTo: rightAnchor, constant: -24),
            eventView.leftAnchor.constraint(equalTo: leftAnchor, constant: 106),
        ])
    }
}

struct Event {
    let name: String
    let startTime: Date
    let endTime: Date
    let location: String?
}

