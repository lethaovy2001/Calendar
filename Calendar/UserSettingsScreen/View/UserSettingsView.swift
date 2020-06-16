//
//  UserSettingsView.swift
//  Calendar
//
//  Created by Vy Le on 6/12/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

final class UserSettingsView: UIView {
    // MARK: - Properties
    private let logoutButton = RoundedButton(title: "LOGOUT", color: AppColor.primaryColor)
    private let backButton = BackButton()
    
    // MARK: - Initializer
    init() {
        super.init(frame: .zero)
        setup()
        self.backgroundColor = .white
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
        addSubview(logoutButton)
        addSubview(backButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 36),
            backButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 36)
        ])
        NSLayoutConstraint.activate([
            logoutButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoutButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            logoutButton.widthAnchor.constraint(equalToConstant: 140),
            logoutButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    func setLogoutSelector(target: UIViewController, selector: Selector) {
        logoutButton.addTarget(target, action: selector, for: .touchUpInside)
    }
    
    func setBackButtonSelector(target: UIViewController, selector: Selector) {
        backButton.addTarget(target, action: selector, for: .touchUpInside)
    }
    
    func pressedLogoutButton() {
        logoutButton.pulsate()
    }
}
