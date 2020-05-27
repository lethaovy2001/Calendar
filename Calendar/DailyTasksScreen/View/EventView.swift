//
//  EventView.swift
//  Calendar
//
//  Created by Vy Le on 5/26/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

final class EventView : CustomContainerView {
    // MARK: - Properties
    private let titleLabel = CustomLabel(text: "Morning Exercise", textColor: UIColor.darkGray, textSize: 18, textWeight: .bold)
    private var iconButton = IconButton(name: "mappin", size: 18, color: AppColor.gray)
    private var locationLabel = CustomLabel(text: "Location", textColor: .darkGray, textSize: 16, textWeight: .regular)
    
    // MARK: - Initializer
    override init() {
        super.init(backgroundColor: AppColor.lightPurple, cornerRadius: 20)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup
    private func setup() {
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        addSubview(titleLabel)
        addSubview(iconButton)
        addSubview(locationLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 24),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -24),
        ])
        NSLayoutConstraint.activate([
            iconButton.heightAnchor.constraint(equalToConstant: 20),
            iconButton.widthAnchor.constraint(equalToConstant: 20),
            iconButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 24),
            iconButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
        ])
        NSLayoutConstraint.activate([
            locationLabel.leftAnchor.constraint(equalTo: iconButton.rightAnchor, constant: 4),
            locationLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -24),
            locationLabel.centerYAnchor.constraint(equalTo: iconButton.centerYAnchor),
        ])
    }
}
