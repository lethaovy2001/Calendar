//
//  SettingsContainerView.swift
//  Calendar
//
//  Created by Vy Le on 6/8/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

final class SettingsContainerView: UIView {
    // MARK: - Properties
    private let bookRing = BookRingView()
    private let containerView = CustomContainerView(
        backgroundColor: .white,
        cornerRadius: 20,
        hasShadow: true
    )
    private let iconButton: IconButton
    private let label = CustomLabel(
        text: "N/A",
        textColor: AppColor.gray,
        textSize: 18,
        textWeight: .regular
    )
    
    // MARK: - Initializer
    init(iconName: String) {
        iconButton = IconButton(
            name: iconName,
            size: 18,
            color: AppColor.darkGray
        )
        label.numberOfLines = 2
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
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
        addSubview(containerView)
        addSubview(bookRing)
        bringSubviewToFront(bookRing)
        containerView.addSubview(iconButton)
        containerView.addSubview(label)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            bookRing.topAnchor.constraint(equalTo: topAnchor),
            bookRing.rightAnchor.constraint(equalTo: rightAnchor),
            bookRing.leftAnchor.constraint(equalTo: leftAnchor)
        ])
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: bookRing.bottomAnchor, constant: -30),
            containerView.leftAnchor.constraint(equalTo: leftAnchor),
            containerView.rightAnchor.constraint(equalTo: rightAnchor),
            containerView.bottomAnchor.constraint(equalTo: label.bottomAnchor, constant: 24)
        ])
        NSLayoutConstraint.activate([
            iconButton.topAnchor.constraint(equalTo: bookRing.bottomAnchor, constant: 12),
            iconButton.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 36),
            iconButton.widthAnchor.constraint(equalToConstant: 36)
        ])
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: iconButton.centerYAnchor),
            label.leftAnchor.constraint(equalTo: iconButton.rightAnchor, constant: 24),
            label.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -24)
        ])
        NSLayoutConstraint.activate([
            self.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
}
