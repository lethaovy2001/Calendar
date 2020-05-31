//
//  NewEventView.swift
//  Calendar
//
//  Created by Vy Le on 5/31/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

final class NewEventView : UIView {
    // MARK: - Properties
    private let saveButton = RoundedButton(title: "Save", color: AppColor.green)
    private let exitButton = IconButton(name: "xmark", size: 20, color: AppColor.primaryColor)
    private let titleTextField = CustomTextField(placeholder: "Add Title", keyboardType: .default)
    private let scrollView = CustomScrollView()
    
    // MARK: - Initializer
    init() {
        super.init(frame: .zero)
        setup()
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
        addSubview(scrollView)
        addSubview(exitButton)
        addSubview(saveButton)
        addSubview(titleTextField)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            saveButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -24),
            saveButton.widthAnchor.constraint(equalToConstant: 80)
        ])
        NSLayoutConstraint.activate([
            exitButton.centerYAnchor.constraint(equalTo: saveButton.centerYAnchor),
            exitButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 24),
        ])
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 24),
            titleTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 24),
            titleTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -24),
        ])
    }
}
