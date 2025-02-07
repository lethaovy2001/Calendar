//
//  DailyTasksMainView.swift
//  Calendar
//
//  Created by Vy Le on 5/25/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

final class DailyTasksMainView: UIView {
    // MARK: - Properties
    private let scrollView = CustomScrollView()
    private let headerLabel = CustomLabel(
        text: "Daily Tasks",
        textColor: AppColor.darkGray,
        textSize: 36,
        textWeight: .heavy
    )
    private let timeLine = RunningTimeLineView()
    private let bottomBar = BottomBarView()
    private let eventLayoutGenerator = EventLayoutGenerator()
    
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
        setupTimeLineConstraints()
    }
    
    private func setupSelf() {
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func addSubviews() {
        addSubview(headerLabel)
        addSubview(scrollView)
        addSubview(bottomBar)
        scrollView.addSubview(timeLine)
        scrollView.bringSubviewToFront(timeLine)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 80),
            headerLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 36)
        ])
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor, constant: 160),
            scrollView.leftAnchor.constraint(equalTo: self.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: self.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            bottomBar.heightAnchor.constraint(equalToConstant: 90),
            bottomBar.leftAnchor.constraint(equalTo: leftAnchor),
            bottomBar.rightAnchor.constraint(equalTo: rightAnchor),
            bottomBar.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupTimeLineConstraints() {
        let date = Date()
        let offset = eventLayoutGenerator.estimateTopOffset(of: date) - 4
        NSLayoutConstraint.activate([
            timeLine.heightAnchor.constraint(equalToConstant: 8),
            timeLine.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: offset),
            timeLine.rightAnchor.constraint(equalTo: rightAnchor),
            timeLine.leftAnchor.constraint(equalTo: leftAnchor, constant: Constants.spaceBetweenTimeDivider)
        ])
        self.layoutIfNeeded()
        self.scrollView.setContentOffset(CGPoint(x: 0, y: offset), animated: false)
        Timer.scheduledTimer(timeInterval: Constants.Time.minutesInAHour,
                             target: self,
                             selector: #selector(animateTimeLineRunning),
                             userInfo: nil,
                             repeats: true)
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
                    divider.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -120)
                ])
            }
        }
    }
    
    func setEvent(event: Event) {
        let height = eventLayoutGenerator.estimateHeight(event: event)
        let offset = eventLayoutGenerator.estimateTopOffset(of: event.startTime)
        let eventView = EventView(height: height)
        scrollView.addSubview(eventView)
        NSLayoutConstraint.activate([
            eventView.heightAnchor.constraint(equalToConstant: height),
            eventView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: offset),
            eventView.rightAnchor.constraint(equalTo: rightAnchor, constant: -24),
            eventView.leftAnchor.constraint(equalTo: leftAnchor, constant: 106)
        ])
    }
    
    // MARK: Selectors
    func setCalendarButtonSelector(selector: Selector, target: UIViewController) {
        bottomBar.setCalendarButtonSelector(selector: selector, target: target)
    }
    
    func setProfileButtonSelector(selector: Selector, target: UIViewController) {
        bottomBar.setProfileButtonSelector(selector: selector, target: target)
    }
    
    func setAddButtonSelector(selector: Selector, target: UIViewController) {
        bottomBar.setAddButtonSelector(selector: selector, target: target)
    }
    
    // MARK: Actions
    @objc func animateTimeLineRunning() {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
            self.timeLine.frame.origin.y += 1.4
        }, completion: nil)
    }
}
