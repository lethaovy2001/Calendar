//
//  CustomDatePicker.swift
//  Calendar
//
//  Created by Vy Le on 5/31/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

final class DatePickerView: UIView {
    // MARK: - Properties
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker(frame: .zero)
        datePicker.datePickerMode = .dateAndTime
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    private let doneButton = TextButton(title: "DONE", color: AppColor.primaryColor)
    private let containerView = CustomContainerView(
        backgroundColor: .white,
        cornerRadius: 6,
        hasShadow: true
    )
    private let title = CustomLabel(
        text: "Start",
        textColor: AppColor.primaryColor,
        textSize: 30,
        textWeight: .bold
    )
    weak var tapDelegate: DatePickerTapGestureDelegate?
    
    // MARK: - Initializer
    init() {
        super.init(frame: .zero)
        setup()
        self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setup() {
        addSubviews()
        setupConstraints()
        addGesture()
    }
    
    private func addSubviews() {
        addSubview(containerView)
        containerView.addSubview(doneButton)
        containerView.addSubview(datePicker)
        containerView.addSubview(title)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 340),
            containerView.leftAnchor.constraint(equalTo: leftAnchor, constant: 36),
            containerView.rightAnchor.constraint(equalTo: rightAnchor, constant: -36)
        ])
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 24),
            title.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 36)
        ])
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: title.bottomAnchor),
            datePicker.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            doneButton.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16),
            doneButton.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16),
            doneButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            doneButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    private func addGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        doneButton.addGestureRecognizer(tapGesture)
    }
    
    // MARK: Actions
    @objc private func handleTapGesture() {
        self.removeFromSuperview()
        tapDelegate?.setDate(getDatePickerDate())
    }
    
    func getDatePickerDate() -> Date {
        return datePicker.date
    }
}
