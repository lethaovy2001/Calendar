//
//  EventView.swift
//  Calendar
//
//  Created by Vy Le on 5/26/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

final class EventView: CustomContainerView {
    // MARK: - Properties
    private let titleLabel = CustomLabel(
        text: "Title",
        textColor: AppColor.darkGray,
        textSize: 18,
        textWeight: .bold
    )
    private var iconButton = IconButton(
        name: "mappin",
        size: 18,
        color: AppColor.gray
    )
    private var locationLabel = CustomLabel(
        text: "Location",
        textColor: AppColor.gray,
        textSize: 16,
        textWeight: .semibold
    )
    private var eventColors = AppColor.eventColors
    private var height: CGFloat
    
    // MARK: - Initializer
    init(height: CGFloat) {
        self.height = height
        super.init()
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
    }
    
    private func setupSelf() {
        if height <= 0.25 * Constants.spaceBetweenTimeDivider {
            self.setCornerRadius(cornerRadius: 10)
        } else {
            self.setCornerRadius(cornerRadius: 20)
        }
        let randomNum = Int.random(in: 0..<eventColors.count)
        self.setBackgroundColor(eventColors[randomNum])
    }
    
    private func addSubviews() {
        addSubview(titleLabel)
        addSubview(iconButton)
        addSubview(locationLabel)
    }
    
    private func setupConstraints() {
        if height <= 0.25 * Constants.spaceBetweenTimeDivider {
            self.showTitleOnly()
        } else if height <= 0.5 * Constants.spaceBetweenTimeDivider {
            self.showTitleOnly()
        } else if height <= 0.75 * Constants.spaceBetweenTimeDivider {
            self.centerTitleAndLocation()
        } else {
            self.topConstraintTitleAndLocation()
        }
    }
    
    // MARK: - Constraints
    private func topConstraintTitleAndLocation() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 24),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -24)
        ])
        setupLocationConstraint()
    }
    
    private func showTitleOnly() {
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 24),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -24)
        ])
        iconButton.removeFromSuperview()
        locationLabel.removeFromSuperview()
    }
    
    private func centerTitleAndLocation() {
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -12),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 24),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -24)
        ])
        setupLocationConstraint()
    }
    
    private func setupLocationConstraint() {
        NSLayoutConstraint.activate([
            iconButton.heightAnchor.constraint(equalToConstant: 20),
            iconButton.widthAnchor.constraint(equalToConstant: 20),
            iconButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 24),
            iconButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4)
        ])
        NSLayoutConstraint.activate([
            locationLabel.leftAnchor.constraint(equalTo: iconButton.rightAnchor, constant: 4),
            locationLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -24),
            locationLabel.centerYAnchor.constraint(equalTo: iconButton.centerYAnchor)
        ])
    }
}
