//
//  NotificationContainerView.swift
//  Calendar
//
//  Created by Vy Le on 6/8/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

final class NotificationContainerView: UIView {
    // MARK: - Properties
    private let bookRing = BookRingView()
    private let containerView = CustomContainerView(
        backgroundColor: .white,
        cornerRadius: 20,
        hasShadow: true
    )
    private let notificationIcon = IconButton(
        name: Constants.IconNames.alarm,
        size: 20,
        color: AppColor.darkGray
    )
    private let notificationLabel = CustomLabel(
        text: "N/A",
        textColor: AppColor.gray,
        textSize: 18,
        textWeight: .regular
    )
    
    // MARK: - Initializer
    init() {
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
        containerView.addSubview(notificationIcon)
        containerView.addSubview(notificationLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            bookRing.topAnchor.constraint(equalTo: topAnchor),
            bookRing.rightAnchor.constraint(equalTo: rightAnchor),
            bookRing.leftAnchor.constraint(equalTo: leftAnchor),
            bookRing.heightAnchor.constraint(equalToConstant: 40)
        ])
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: bookRing.bottomAnchor, constant: -12),
            containerView.leftAnchor.constraint(equalTo: leftAnchor),
            containerView.rightAnchor.constraint(equalTo: rightAnchor),
            containerView.bottomAnchor.constraint(equalTo: notificationLabel.bottomAnchor, constant: 24)
        ])
        NSLayoutConstraint.activate([
            notificationIcon.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 36),
            notificationIcon.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 36),
            notificationIcon.widthAnchor.constraint(equalToConstant: 36)
        ])
        NSLayoutConstraint.activate([
            notificationLabel.centerYAnchor.constraint(equalTo: notificationIcon.centerYAnchor),
            notificationLabel.leftAnchor.constraint(equalTo: notificationIcon.rightAnchor, constant: 24),
            notificationLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -24)
        ])
    }
}
