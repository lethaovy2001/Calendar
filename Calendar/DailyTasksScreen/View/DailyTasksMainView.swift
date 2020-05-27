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
    let timeLine = TimeLineView(time: 1)
    
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
    
    private func addSubViews() {
        addSubview(headerLabel)
        addSubview(scrollView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 48),
            headerLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 36),
        ])
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor, constant: 120),
            scrollView.leftAnchor.constraint(equalTo: self.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: self.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}

