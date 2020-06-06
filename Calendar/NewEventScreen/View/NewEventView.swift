//
//  NewEventView.swift
//  Calendar
//
//  Created by Vy Le on 5/31/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

final class NewEventView: UIView {
    // MARK: - Properties
    private let saveButton = RoundedButton(title: "Save", color: AppColor.green)
    private let exitButton = IconButton(
        name: Constants.IconNames.exit,
        size: 20,
        color: AppColor.primaryColor
    )
    private let titleTextField = CustomTextField(placeholder: "Add Title")
    private let scrollView = CustomScrollView()
    private let timeSectionLabel = SectionTitleLabel(title: "TIME")
    private let startTitleLabel = CustomLabel(
        text: "Start",
        textColor: AppColor.darkGray,
        textSize: 18,
        textWeight: .bold
    )
    private let startTime = CustomLabel(
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
    private let endTime = CustomLabel(
        text: "date...",
        textColor: AppColor.gray,
        textSize: 18,
        textWeight: .regular
    )
    private let locationSectionLabel = SectionTitleLabel(title: "LOCATION")
    private let locationTextField = CustomTextField(placeholder: "Add Location")
    private let noteSectionLabel = SectionTitleLabel(title: "NOTES")
    private let noteTextView = CustomTextView(text: "Notes...")
    private let settingsSectionLabel = SectionTitleLabel(title: "SETTINGS")
    private let alarmButton = IconButton(
        name: Constants.IconNames.alarm,
        size: 24,
        color: AppColor.gray
    )
    private let repeatButton = IconButton(
        name: Constants.IconNames.repeatName,
        size: 24,
        color: AppColor.gray
    )
    private let addAlertButton = TextButton(
        title: "Add alert",
        textColor: AppColor.gray,
        textSize: 18,
        textWeight: .regular
    )
    private let donotRepeatButton = TextButton(
        title: "Don't repeat",
        textColor: AppColor.gray,
        textSize: 18,
        textWeight: .regular
    )
    private let datePickerView = DatePickerView()
    private let notificationView = CustomNotificationView()
    private let dateConverter = DateConverter()
    private var selectedTimeLabel: CustomLabel?
    
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
        addGesture()
        addDelegate()
        setupStartAndEndTime()
    }
    
    private func addDelegate() {
        datePickerView.tapDelegate = self
    }
    
    private func addGesture() {
        let startTimeTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        startTimeTapGesture.numberOfTapsRequired = 1
        startTimeTapGesture.numberOfTouchesRequired = 1
        startTime.isUserInteractionEnabled = true
        startTime.addGestureRecognizer(startTimeTapGesture)
        
        let endTimeTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        endTimeTapGesture.numberOfTapsRequired = 1
        endTimeTapGesture.numberOfTouchesRequired = 1
        endTime.isUserInteractionEnabled = true
        endTime.addGestureRecognizer(endTimeTapGesture)
        
        let addAlertTapGesture = UITapGestureRecognizer(target: self, action: #selector(showNotificationView))
        addAlertTapGesture.numberOfTapsRequired = 1
        addAlertTapGesture.numberOfTouchesRequired = 1
        addAlertButton.addGestureRecognizer(addAlertTapGesture)
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
        bringSubviewToFront(titleTextField)
    }
    
    private func setupConstraints() {
        constraintHeader()
        constraintEventInput()
    }
    
    private func constraintHeader() {
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            saveButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -24),
            saveButton.widthAnchor.constraint(equalToConstant: 80)
        ])
        NSLayoutConstraint.activate([
            exitButton.centerYAnchor.constraint(equalTo: saveButton.centerYAnchor),
            exitButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 24)
        ])
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 24),
            titleTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 24),
            titleTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -24)
        ])
    }
    
    private func constraintEventInput() {
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            saveButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -24),
            saveButton.widthAnchor.constraint(equalToConstant: 80)
        ])
        NSLayoutConstraint.activate([
            exitButton.centerYAnchor.constraint(equalTo: saveButton.centerYAnchor),
            exitButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 24)
        ])
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 24),
            titleTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 24),
            titleTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -24)
        ])
    }
    
    private func setupStartAndEndTime() {
        let date = datePickerView.getDatePickerDate()
        let dateString = dateConverter.getDateString(from: date)
        startTime.setText(text: dateString)
        endTime.setText(text: dateString)
    }
    
    // MARK: Actions
    @objc private func handleTapGesture(sender: UITapGestureRecognizer) {
        addSubview(datePickerView)
        bringSubviewToFront(datePickerView)
        NSLayoutConstraint.activate([
            datePickerView.topAnchor.constraint(equalTo: topAnchor),
            datePickerView.leftAnchor.constraint(equalTo: leftAnchor),
            datePickerView.rightAnchor.constraint(equalTo: rightAnchor),
            datePickerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        selectedTimeLabel = sender.view as? CustomLabel
    }
    
    @objc private func showNotificationView() {
        addSubview(notificationView)
        bringSubviewToFront(notificationView)
        NSLayoutConstraint.activate([
            notificationView.topAnchor.constraint(equalTo: topAnchor),
            notificationView.leftAnchor.constraint(equalTo: leftAnchor),
            notificationView.rightAnchor.constraint(equalTo: rightAnchor),
            notificationView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    // MARK: Selectors
    func setExitButtonSelector(target: UIViewController, selector: Selector) {
        exitButton.addTarget(target, action: selector, for: .touchUpInside)
    }
    
    func setSaveButtonSelector(target: UIViewController, selector: Selector) {
        saveButton.addTarget(target, action: selector, for: .touchUpInside)
    }
    
    func registerCellId(viewController: NewEventViewController) {
        notificationView.registerCellId(viewController: viewController)
    }
    
    func getSavedEvent() -> Event? {
        guard
            let name = titleTextField.text,
            let startTimeText = startTime.text,
            let endTimeText = endTime.text,
            let startTime = dateConverter.convertToDate(from: startTimeText),
            let endTime = dateConverter.convertToDate(from: endTimeText)
        else { return nil }
        let event = Event(
            name: name,
            startTime: startTime,
            endTime: endTime,
            location: locationTextField.text,
            notes: noteTextView.text
        )
        return event
    }
    
    func getTimeSetForAlert() -> Int? {
        return notificationView.getTimeTextField()
    }
}

// MARK: DatePickerTapGestureDelegate
extension NewEventView: DatePickerTapGestureDelegate {
    func setDate(_ date: Date) {
        let dateString = dateConverter.getDateString(from: date)
        selectedTimeLabel?.setText(text: dateString)
    }
}
