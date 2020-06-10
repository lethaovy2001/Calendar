//
//  EventDetailsView.swift
//  Calendar
//
//  Created by Vy Le on 6/8/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

final class EventDetailsView: UIView {
    // MARK: - Properties
    private let scrollView = CustomScrollView()
    private let titleContainer = TitleContainerView()
    private let exitButton = IconButton(
        name: Constants.IconNames.exit,
        size: 20,
        color: AppColor.darkGray
    )
    private let editButton = IconButton(
        name: Constants.IconNames.edit,
        size: 20,
        color: AppColor.darkGray
    )
    private let moreButton = IconButton(
        name: Constants.IconNames.more,
        size: 20,
        color: AppColor.darkGray
    )
    private let timeContainerView = TimeContainerView()
    
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
        configureSelf()
        addSubviews()
        setupConstraints()
    }
    
    private func configureSelf() {
        self.backgroundColor = AppColor.pastelPurple
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func addSubviews() {
        addSubview(scrollView)
        scrollView.addSubview(exitButton)
        scrollView.addSubview(moreButton)
        scrollView.addSubview(editButton)
        scrollView.addSubview(titleContainer)
        scrollView.addSubview(timeContainerView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leftAnchor.constraint(equalTo: leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            exitButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 36),
            exitButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 36)
        ])
        NSLayoutConstraint.activate([
            moreButton.centerYAnchor.constraint(equalTo: exitButton.centerYAnchor),
            moreButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -36)
        ])
        NSLayoutConstraint.activate([
            editButton.centerYAnchor.constraint(equalTo: exitButton.centerYAnchor),
            editButton.rightAnchor.constraint(equalTo: moreButton.leftAnchor, constant: -12)
        ])
        NSLayoutConstraint.activate([
            titleContainer.topAnchor.constraint(equalTo: exitButton.bottomAnchor, constant: 36),
            titleContainer.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 36),
            titleContainer.rightAnchor.constraint(equalTo: rightAnchor, constant: -36),
            titleContainer.heightAnchor.constraint(equalToConstant: 80)
        ])
        NSLayoutConstraint.activate([
            timeContainerView.topAnchor.constraint(equalTo: titleContainer.bottomAnchor, constant: -8),
            timeContainerView.leftAnchor.constraint(equalTo: leftAnchor, constant: 36),
            timeContainerView.rightAnchor.constraint(equalTo: rightAnchor, constant: -36)
        ])
    }
}
