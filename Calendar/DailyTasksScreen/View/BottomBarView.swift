//
//  BottomBarView.swift
//  Calendar
//
//  Created by Vy Le on 5/27/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

final class BottomBarView : CustomContainerView {
    // MARK: - Properties
    private let calendarButton = IconButton(name: Constants.IconNames.calendar, size: 24, color: AppColor.gray)
    private let profileButton = IconButton(name: Constants.IconNames.profile, size: 24, color: AppColor.gray)
    private let addButton = IconButton(name: Constants.IconNames.add, size: 24, color: AppColor.primaryColor)
    
    // MARK: - Initializer
    override init() {
        super.init(backgroundColor: .white)
        setup()
        self.addTopShadow()
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
        self.addSubview(calendarButton)
        self.addSubview(profileButton)
        self.addSubview(addButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            addButton.widthAnchor.constraint(equalToConstant: 36),
            addButton.heightAnchor.constraint(equalToConstant: 36),
            addButton.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            addButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            calendarButton.widthAnchor.constraint(equalToConstant: 36),
            calendarButton.heightAnchor.constraint(equalToConstant: 36),
            calendarButton.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            calendarButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 24)
        ])
        NSLayoutConstraint.activate([
            profileButton.widthAnchor.constraint(equalToConstant: 36),
            profileButton.heightAnchor.constraint(equalToConstant: 36),
            profileButton.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            profileButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -24)
        ])
    }
    
    // MARK: Selectors
    func setCalendarButtonSelector(selector: Selector, target: UIViewController) {
        calendarButton.addTarget(target, action: selector, for: .touchUpInside)
    }
    
    func setProfileButtonSelector(selector: Selector, target: UIViewController) {
        profileButton.addTarget(target, action: selector, for: .touchUpInside)
    }
    
    func setAddButtonSelector(selector: Selector, target: UIViewController) {
        addButton.addTarget(target, action: selector, for: .touchUpInside)
    }
}
