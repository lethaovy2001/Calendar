//
//  LoginView.swift
//  Calendar
//
//  Created by Vy Le on 5/24/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class LoginView : UIView {
    // MARK: - Properties
    private let appLogo = AppLogoView()
    private let emailInputView = InputView(type: .email)
    private let passwordInputView = InputView(type: .password)
    
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
        setupSelf()
        addSubViews()
        setupConstraints()
    }
    
    private func setupSelf() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func addSubViews() {
        addSubview(appLogo)
        addSubview(emailInputView)
        addSubview(passwordInputView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            appLogo.topAnchor.constraint(equalTo: topAnchor, constant: 90),
            appLogo.centerXAnchor.constraint(equalTo: centerXAnchor),
            appLogo.heightAnchor.constraint(equalToConstant: 140),
            appLogo.widthAnchor.constraint(equalToConstant: 140)
        ])
        NSLayoutConstraint.activate([
            emailInputView.topAnchor.constraint(equalTo: appLogo.bottomAnchor, constant: 72),
            emailInputView.leftAnchor.constraint(equalTo: leftAnchor, constant: 36),
            emailInputView.rightAnchor.constraint(equalTo: rightAnchor, constant: -36),
            emailInputView.heightAnchor.constraint(equalToConstant: 48)
        ])
        NSLayoutConstraint.activate([
            passwordInputView.topAnchor.constraint(equalTo: emailInputView.bottomAnchor, constant: 24),
            passwordInputView.leftAnchor.constraint(equalTo: leftAnchor, constant: 36),
            passwordInputView.rightAnchor.constraint(equalTo: rightAnchor, constant: -36),
            passwordInputView.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}
