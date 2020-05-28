//
//  TimeDividerView.swift
//  Calendar
//
//  Created by Vy Le on 5/26/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

final class TimeDividerView : UIView {
    // MARK: - Properties
    private let timeLabel = CustomLabel(text: "N/A", textColor: AppColor.timeColor, textSize: 16, textWeight: .bold)
    private let dividerLine = CustomContainerView(backgroundColor: AppColor.dividerColor)
    private let stringConverter = StringConverter()
    
    // MARK: - Initializer
    init(time: Int) {
        super.init(frame: .zero)
        setup()
        if time <= 24 {
            timeLabel.setText(text: stringConverter.convert(time))
        }
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setup() {
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        self.addSubview(timeLabel)
        self.addSubview(dividerLine)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: topAnchor),
            timeLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            timeLabel.leftAnchor.constraint(equalTo: leftAnchor),
        ])
        NSLayoutConstraint.activate([
            dividerLine.centerYAnchor.constraint(equalTo: timeLabel.centerYAnchor),
            dividerLine.leftAnchor.constraint(equalTo: timeLabel.rightAnchor, constant: 10),
            dividerLine.rightAnchor.constraint(equalTo: rightAnchor),
            dividerLine.heightAnchor.constraint(equalToConstant: 2)
        ])
    }
}
