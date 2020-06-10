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
    private let startTimeLabel = CustomLabel(
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
    private let endTimeLabel = CustomLabel(
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
    var keyboardFrame = CGRect()
    private var doNotRepeatButtonBottomAnchor: NSLayoutConstraint?
    
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
        setupStartAndEndTime()
    }

    private func addGesture() {
        let startTimeTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        startTimeTapGesture.numberOfTapsRequired = 1
        startTimeTapGesture.numberOfTouchesRequired = 1
        startTimeLabel.isUserInteractionEnabled = true
        startTimeLabel.addGestureRecognizer(startTimeTapGesture)
        
        let endTimeTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        endTimeTapGesture.numberOfTapsRequired = 1
        endTimeTapGesture.numberOfTouchesRequired = 1
        endTimeLabel.isUserInteractionEnabled = true
        endTimeLabel.addGestureRecognizer(endTimeTapGesture)
        
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
        scrollView.addSubview(startTimeLabel)
        scrollView.addSubview(endTimeLabel)
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
    
    // MARK: Constraints
    private func setupConstraints() {
        constraintHeader()
        constraintEventInput()
        constraintSettings()
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
            scrollView.topAnchor.constraint(equalTo: self.topAnchor, constant: 160),
            scrollView.leftAnchor.constraint(equalTo: leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            timeSectionLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 24),
            timeSectionLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 24)
        ])
        NSLayoutConstraint.activate([
            startTitleLabel.topAnchor.constraint(equalTo: timeSectionLabel.bottomAnchor, constant: 12),
            startTitleLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 24),
            startTitleLabel.widthAnchor.constraint(equalToConstant: 60)
        ])
        NSLayoutConstraint.activate([
            endTitleLabel.topAnchor.constraint(equalTo: startTitleLabel.bottomAnchor, constant: 12),
            endTitleLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 24),
            endTitleLabel.widthAnchor.constraint(equalToConstant: 60)
        ])
        NSLayoutConstraint.activate([
            startTimeLabel.centerYAnchor.constraint(equalTo: startTitleLabel.centerYAnchor),
            startTimeLabel.leftAnchor.constraint(equalTo: startTitleLabel.rightAnchor, constant: 12)
        ])
        NSLayoutConstraint.activate([
            endTimeLabel.centerYAnchor.constraint(equalTo: endTitleLabel.centerYAnchor),
            endTimeLabel.leftAnchor.constraint(equalTo: endTitleLabel.rightAnchor, constant: 12)
        ])
        NSLayoutConstraint.activate([
            locationSectionLabel.topAnchor.constraint(equalTo: endTimeLabel.bottomAnchor, constant: 24),
            locationSectionLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 24)
        ])
        NSLayoutConstraint.activate([
            locationTextField.topAnchor.constraint(equalTo: locationSectionLabel.bottomAnchor, constant: 12),
            locationTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 24),
            locationTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -24)
        ])
        NSLayoutConstraint.activate([
            noteSectionLabel.topAnchor.constraint(equalTo: locationTextField.bottomAnchor, constant: 24),
            noteSectionLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 24)
        ])
        NSLayoutConstraint.activate([
            noteTextView.topAnchor.constraint(equalTo: noteSectionLabel.bottomAnchor, constant: 12),
            noteTextView.leftAnchor.constraint(equalTo: leftAnchor, constant: 24),
            noteTextView.rightAnchor.constraint(equalTo: rightAnchor, constant: -24)
        ])
    }
    
    private func constraintSettings() {
        NSLayoutConstraint.activate([
            settingsSectionLabel.topAnchor.constraint(equalTo: noteTextView.bottomAnchor, constant: 24),
            settingsSectionLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 24)
        ])
        NSLayoutConstraint.activate([
            alarmButton.topAnchor.constraint(equalTo: settingsSectionLabel.bottomAnchor, constant: 12),
            alarmButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 24),
            alarmButton.widthAnchor.constraint(equalToConstant: 40)
        ])
        NSLayoutConstraint.activate([
            addAlertButton.centerYAnchor.constraint(equalTo: alarmButton.centerYAnchor),
            addAlertButton.leftAnchor.constraint(equalTo: alarmButton.rightAnchor, constant: 12)
        ])
        NSLayoutConstraint.activate([
            repeatButton.topAnchor.constraint(equalTo: alarmButton.bottomAnchor, constant: 12),
            repeatButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 24),
            repeatButton.widthAnchor.constraint(equalToConstant: 40)
        ])
        doNotRepeatButtonBottomAnchor = donotRepeatButton.bottomAnchor.constraint(
            equalTo: scrollView.bottomAnchor,
            constant: -24
        )
        NSLayoutConstraint.activate([
            donotRepeatButton.centerYAnchor.constraint(equalTo: repeatButton.centerYAnchor),
            donotRepeatButton.leftAnchor.constraint(equalTo: repeatButton.rightAnchor, constant: 12),
            donotRepeatButton.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: 12),
            doNotRepeatButtonBottomAnchor!
        ])
    }
    
    private func setupStartAndEndTime() {
        let date = datePickerView.getDatePickerDate()
        let dateString = dateConverter.getDateString(from: date)
        startTimeLabel.setText(text: dateString)
        endTimeLabel.setText(text: dateString)
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
}

// MARK: - Public Methods
extension NewEventView {
    func addDelegate(viewController: NewEventViewController) {
        datePickerView.tapDelegate = self
        viewController.keyboardDelegate = self
    }
    
    func addTapGesture(target: UIViewController, selector: Selector) {
        let tapRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: target, action: selector)
        self.addGestureRecognizer(tapRecognizer)
        scrollView.isUserInteractionEnabled = true
        tapRecognizer.cancelsTouchesInView = false
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
    
    // MARK: Getters
    func getSavedEvent() -> Event? {
        guard
            let name = titleTextField.text,
            let startTimeText = startTimeLabel.text,
            let endTimeText = endTimeLabel.text,
            let startTime = dateConverter.convertToDate(from: startTimeText),
            let endTime = dateConverter.convertToDate(from: endTimeText)
        else { return nil }
        guard name != "" else {
            titleTextField.showWarningAnimation()
            return nil
        }
        guard startTime > endTime else {
            startTimeLabel.showWarningAnimation()
            return nil
        }
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

// MARK: - DatePickerTapGestureDelegate
extension NewEventView: DatePickerTapGestureDelegate {
    func setDate(_ date: Date) {
        let dateString = dateConverter.getDateString(from: date)
        selectedTimeLabel?.setText(text: dateString)
    }
}

// MARK: - KeyboardDelegate
extension NewEventView: KeyboardDelegate {
    func showKeyboard() {
        UIView.animate(withDuration: 0.6) {
            self.doNotRepeatButtonBottomAnchor?.constant = -self.keyboardFrame.height + 20
            self.layoutIfNeeded()
        }
    }
    
    func hideKeyboard() {
        UIView.animate(withDuration: 0.6) {
            self.doNotRepeatButtonBottomAnchor?.constant = 0
            self.layoutIfNeeded()
        }
    }
}
