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
    private let exitButton = IconButton(name: Constants.IconNames.exit, size: 20, color: AppColor.primaryColor)
    private let titleTextField = CustomTextField(placeholder: "Add Title")
    private let scrollView = CustomScrollView()
    private let timeSectionLabel = SectionTitleLabel(title: "TIME")
    private let startTitleLabel = CustomLabel(text: "Start", textColor: AppColor.darkGray, textSize: 18, textWeight: .bold)
    private let startTime = CustomLabel(text: "date...", textColor: AppColor.gray, textSize: 18, textWeight: .regular)
    private let endTitleLabel = CustomLabel(text: "End", textColor: AppColor.darkGray, textSize: 18, textWeight: .bold)
    private let endTime = CustomLabel(text: "date...", textColor: AppColor.gray, textSize: 18, textWeight: .regular)
    private let locationSectionLabel = SectionTitleLabel(title: "LOCATION")
    private let locationTextField = CustomTextField(placeholder: "Add Location")
    private let noteSectionLabel = SectionTitleLabel(title: "NOTES")
    private let noteTextView = CustomTextView(text: "Notes...")
    private let settingsSectionLabel = SectionTitleLabel(title: "SETTINGS")
    private let alarmButton = IconButton(name: Constants.IconNames.alarm, size: 24, color: AppColor.gray)
    private let repeatButton = IconButton(name: Constants.IconNames.repeatName, size: 24, color: AppColor.gray)
    private let addAlertButton = TextButton(title: "Add alert", textColor: AppColor.gray, textSize: 18, textWeight: .regular)
    private let donotRepeatButton = TextButton(title: "Don't repeat", textColor: AppColor.gray, textSize: 18, textWeight: .regular)
    
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
        addSubview(exitButton)
        addSubview(saveButton)
        addSubview(titleTextField)
        addSubview(scrollView)
        scrollView.addSubview(timeSectionLabel)
        scrollView.addSubview(startTitleLabel)
        scrollView.addSubview(endTitleLabel)
        scrollView.addSubview(startTime)
        scrollView.addSubview(endTime)
        scrollView.addSubview(locationSectionLabel)
        scrollView.addSubview(locationTextField)
        scrollView.addSubview(noteSectionLabel)
        scrollView.addSubview(noteTextView)
        scrollView.addSubview(settingsSectionLabel)
        scrollView.addSubview(alarmButton)
        scrollView.addSubview(addAlertButton)
        scrollView.addSubview(repeatButton)
        scrollView.addSubview(donotRepeatButton)
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
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor, constant: 160),
            scrollView.leftAnchor.constraint(equalTo: leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        NSLayoutConstraint.activate([
            timeSectionLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 24),
            timeSectionLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 24),
        ])
        NSLayoutConstraint.activate([
            startTitleLabel.topAnchor.constraint(equalTo: timeSectionLabel.bottomAnchor, constant: 12),
            startTitleLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 24),
            startTitleLabel.widthAnchor.constraint(equalToConstant: 60),
        ])
        NSLayoutConstraint.activate([
            endTitleLabel.topAnchor.constraint(equalTo: startTitleLabel.bottomAnchor, constant: 12),
            endTitleLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 24),
            endTitleLabel.widthAnchor.constraint(equalToConstant: 60),
        ])
        NSLayoutConstraint.activate([
            startTime.centerYAnchor.constraint(equalTo: startTitleLabel.centerYAnchor),
            startTime.leftAnchor.constraint(equalTo: startTitleLabel.rightAnchor, constant: 12),
        ])
        NSLayoutConstraint.activate([
            endTime.centerYAnchor.constraint(equalTo: endTitleLabel.centerYAnchor),
            endTime.leftAnchor.constraint(equalTo: endTitleLabel.rightAnchor, constant: 12),
        ])
        NSLayoutConstraint.activate([
            locationSectionLabel.topAnchor.constraint(equalTo: endTime.bottomAnchor, constant: 24),
            locationSectionLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 24),
        ])
        NSLayoutConstraint.activate([
            locationTextField.topAnchor.constraint(equalTo: locationSectionLabel.bottomAnchor, constant: 12),
            locationTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 24),
            locationTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -24),
        ])
        NSLayoutConstraint.activate([
            noteSectionLabel.topAnchor.constraint(equalTo: locationTextField.bottomAnchor, constant: 24),
            noteSectionLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 24),
        ])
        NSLayoutConstraint.activate([
            noteTextView.topAnchor.constraint(equalTo: noteSectionLabel.bottomAnchor, constant: 12),
            noteTextView.leftAnchor.constraint(equalTo: leftAnchor, constant: 24),
            noteTextView.rightAnchor.constraint(equalTo: rightAnchor, constant: -24),
        ])
        NSLayoutConstraint.activate([
            settingsSectionLabel.topAnchor.constraint(equalTo: noteTextView.bottomAnchor, constant: 24),
            settingsSectionLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 24),
        ])
        NSLayoutConstraint.activate([
            alarmButton.topAnchor.constraint(equalTo: settingsSectionLabel.bottomAnchor, constant: 12),
            alarmButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 24),
            alarmButton.widthAnchor.constraint(equalToConstant: 40),
        ])
        NSLayoutConstraint.activate([
            addAlertButton.centerYAnchor.constraint(equalTo: alarmButton.centerYAnchor),
            addAlertButton.leftAnchor.constraint(equalTo: alarmButton.rightAnchor, constant: 12),
        ])
        NSLayoutConstraint.activate([
            repeatButton.topAnchor.constraint(equalTo: alarmButton.bottomAnchor, constant: 12),
            repeatButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 24),
            repeatButton.widthAnchor.constraint(equalToConstant: 40),
        ])
        NSLayoutConstraint.activate([
            donotRepeatButton.centerYAnchor.constraint(equalTo: repeatButton.centerYAnchor),
            donotRepeatButton.leftAnchor.constraint(equalTo: repeatButton.rightAnchor, constant: 12),
        ])
    }
}
