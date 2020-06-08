//
//  TimeContainerView.swift
//  Calendar
//
//  Created by Vy Le on 6/8/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

final class TimeContainerView: UIView {
    // MARK: - Properties
    private let bookRing = BookRingView()
    private let containerView = CustomContainerView(
        backgroundColor: .white,
        cornerRadius: 20,
        hasShadow: true
    )
    private let startTitleLabel = CustomLabel(
        text: "Start",
        textColor: AppColor.darkGray,
        textSize: 18,
        textWeight: .bold
    )
    private let startTimeLabel = CustomLabel(
        text: "date...",
        textColor: AppColor.gray,
        textSize: 18,
        textWeight: .regular
    )
    private let endTitleLabel = CustomLabel(
        text: "End",
        textColor: AppColor.darkGray,
        textSize: 18,
        textWeight: .bold
    )
    private let endTimeLabel = CustomLabel(
        text: "date...",
        textColor: AppColor.gray,
        textSize: 18,
        textWeight: .regular
    )
    
    // MARK: - Initializer
    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .yellow
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
        containerView.addSubview(startTitleLabel)
        containerView.addSubview(endTitleLabel)
        containerView.addSubview(startTimeLabel)
        containerView.addSubview(endTimeLabel)
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
            containerView.bottomAnchor.constraint(equalTo: endTimeLabel.bottomAnchor, constant: 24)
        ])
        NSLayoutConstraint.activate([
            startTitleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 36),
            startTitleLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 24),
            startTitleLabel.widthAnchor.constraint(equalToConstant: 60)
        ])
        NSLayoutConstraint.activate([
            endTitleLabel.topAnchor.constraint(equalTo: startTitleLabel.bottomAnchor, constant: 12),
            endTitleLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 24),
            endTitleLabel.widthAnchor.constraint(equalToConstant: 60)
        ])
        NSLayoutConstraint.activate([
            startTimeLabel.centerYAnchor.constraint(equalTo: startTitleLabel.centerYAnchor),
            startTimeLabel.leftAnchor.constraint(equalTo: startTitleLabel.rightAnchor, constant: 12)
        ])
        NSLayoutConstraint.activate([
            endTimeLabel.centerYAnchor.constraint(equalTo: endTitleLabel.centerYAnchor),
            endTimeLabel.leftAnchor.constraint(equalTo: endTitleLabel.rightAnchor, constant: 12)
        ])
    }
}
