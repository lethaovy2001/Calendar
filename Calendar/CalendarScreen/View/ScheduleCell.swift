//
//  ScheduleCell.swift
//  Calendar
//
//  Created by Vy Le on 5/30/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

final class ScheduleCell : UITableViewCell {
    // MARK: - Properties
    private let verticalBar = CustomContainerView(backgroundColor: AppColor.pastelPurple, cornerRadius: 2)
    private let startTime = CustomLabel(text: "Start", textColor: AppColor.darkGray, textSize: 16, textWeight: .bold)
    private let endTime = CustomLabel(text: "End", textColor: AppColor.gray, textSize: 16, textWeight: .bold)
    private let titleLabel = CustomLabel(text: "Title", textColor: AppColor.darkGray, textSize: 18, textWeight: .bold)
    private var iconButton = IconButton(name: "mappin", size: 18, color: AppColor.gray)
    private var locationLabel = CustomLabel(text: "Location", textColor: AppColor.gray, textSize: 16, textWeight: .semibold)
    
    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setup()
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
        addSubview(verticalBar)
        addSubview(startTime)
        addSubview(endTime)
        addSubview(titleLabel)
        addSubview(iconButton)
        addSubview(locationLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            verticalBar.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            verticalBar.leftAnchor.constraint(equalTo: leftAnchor),
            verticalBar.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6),
            verticalBar.widthAnchor.constraint(equalToConstant: 4),
        ])
        NSLayoutConstraint.activate([
            startTime.topAnchor.constraint(equalTo: verticalBar.topAnchor),
            startTime.leftAnchor.constraint(equalTo: verticalBar.rightAnchor, constant: 12),
            startTime.widthAnchor.constraint(equalToConstant: 60)
        ])
        NSLayoutConstraint.activate([
            endTime.bottomAnchor.constraint(equalTo: verticalBar.bottomAnchor),
            endTime.leftAnchor.constraint(equalTo: verticalBar.rightAnchor, constant: 12),
            endTime.widthAnchor.constraint(equalToConstant: 60)
        ])
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: verticalBar.topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: startTime.rightAnchor, constant: 24),
        ])
        NSLayoutConstraint.activate([
            iconButton.heightAnchor.constraint(equalToConstant: 20),
            iconButton.widthAnchor.constraint(equalToConstant: 20),
            iconButton.leftAnchor.constraint(equalTo: startTime.rightAnchor, constant: 24),
            iconButton.bottomAnchor.constraint(equalTo: endTime.bottomAnchor),
        ])
        NSLayoutConstraint.activate([
            locationLabel.leftAnchor.constraint(equalTo: iconButton.rightAnchor, constant: 4),
            locationLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -24),
            locationLabel.centerYAnchor.constraint(equalTo: iconButton.centerYAnchor),
        ])
    }
    
}
