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
            let topOffset = Constants.spaceBetweenTimeDivider * CGFloat(hour)
            scrollView.addSubview(timeLine)
            NSLayoutConstraint.activate([
                timeLine.heightAnchor.constraint(equalToConstant: 20),
                timeLine.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: topOffset),
                timeLine.rightAnchor.constraint(equalTo: rightAnchor),
                timeLine.leftAnchor.constraint(equalTo: leftAnchor, constant: 24)
            ])
            if hour == Constants.Time.hours {
                NSLayoutConstraint.activate([
                    timeLine.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -60)
                ])
            }
        }
    }
    
    func setEvent(event: Event) {
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

