//
//  LoginView.swift
//  Calendar
//
//  Created by Vy Le on 5/24/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

final class LoginView : UIView {
    // MARK: - Properties
    private let appLogo = AppLogoView()
    private let emailInputView = InputView(type: .email)
    private let passwordInputView = InputView(type: .password)
    private let loginButton = RoundedButton(title: "LOGIN", color: AppColor.primaryColor)
    private let errorLabel = ErrorLabel()
    
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
        addSubview(loginButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            appLogo.topAnchor.constraint(equalTo: topAnchor, constant: 90),
            appLogo.centerXAnchor.constraint(equalTo: centerXAnchor),
            appLogo.heightAnchor.constraint(equalToConstant: 160),
            appLogo.widthAnchor.constraint(equalToConstant: 160)
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
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passwordInputView.bottomAnchor, constant: 72),
            loginButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 36),
            loginButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -36),
            loginButton.heightAnchor.constraint(equalToConstant: 54)
        ])
    }
    
    // MARK: - Public Functions
    func addDelegate(viewController: LoginViewController) {
        
    }
    
    func addTapGesture(target: UIViewController, selector: Selector) {
        let tapRecognizer = UITapGestureRecognizer(target: target, action: selector)
        tapRecognizer.cancelsTouchesInView = false
        self.addGestureRecognizer(tapRecognizer)
    }
    
    func setLoginSelector(selector: Selector, target: UIViewController) {
        loginButton.addTarget(target, action: selector, for: .touchUpInside)
    }
    
    func showError(message: String) {
        addSubview(errorLabel)
        NSLayoutConstraint.activate([
            errorLabel.topAnchor.constraint(equalTo: passwordInputView.bottomAnchor, constant: 6),
            errorLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 48),
            errorLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -48),
            errorLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        errorLabel.setText(text: message)
    }
    
    // MARK: Getters
    func getEmailAddress() -> String? {
        return emailInputView.getText()
    }
    
    func getPassword() -> String? {
        return passwordInputView.getText()
    }
}
