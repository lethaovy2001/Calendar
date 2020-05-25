//
//  InputView.swift
//  Calendar
//
//  Created by Vy Le on 5/24/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

final class InputView : CustomContainerView {
    // MARK: - Properties
    private var iconButton: IconButton!
    private var textField: CustomTextField!
    
    enum InputType {
        case email
        case password
    }
    
    // MARK: - Initializer
    init(type: InputType) {
        super.init(backgroundColor: AppColor.inputColor, cornerRadius: 10)
        self.translatesAutoresizingMaskIntoConstraints = false
        switch type {
        case .email:
            iconButton = IconButton(name: "person.fill", size: 18, color: AppColor.gray)
            textField = CustomTextField(placeholder: "Email", keyboardType: .emailAddress)
        case .password:
            iconButton = IconButton(name: "lock.fill", size: 18, color: AppColor.gray)
            textField = CustomTextField(placeholder: "Password", keyboardType: .default)
            textField.isSecureTextEntry = true
        }
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
        addSubview(iconButton)
        addSubview(textField)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            iconButton.heightAnchor.constraint(equalToConstant: 30),
            iconButton.widthAnchor.constraint(equalToConstant: 30),
            iconButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 12),
            iconButton.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
        NSLayoutConstraint.activate([
            textField.leftAnchor.constraint(equalTo: iconButton.rightAnchor),
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.rightAnchor.constraint(equalTo: rightAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
