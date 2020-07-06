//
//  EventDetailsView.swift
//  Calendar
//
//  Created by Vy Le on 6/8/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

final class EventDetailsView: UIView {
    // MARK: - Properties
    private let scrollView = CustomScrollView()
    private let titleContainer = TitleContainerView()
    private let exitButton = IconButton(
        name: Constants.IconNames.exit,
        size: 20,
        color: AppColor.darkGray
    )
    private let editButton = IconButton(
        name: Constants.IconNames.edit,
        size: 20,
        color: AppColor.darkGray
    )
    private let moreButton = IconButton(
        name: Constants.IconNames.more,
        size: 20,
        color: AppColor.darkGray
    )
    private let timeContainerView = TimeContainerView()
    private let alarmSettingsView = SettingsContainerView(iconName: Constants.IconNames.alarm)
    private let repeatSettingsView = SettingsContainerView(iconName: Constants.IconNames.repeatName)
    private let locationSettingsView = SettingsContainerView(iconName: Constants.IconNames.mappin)
    private let notesContainerView = NotesContainerView()
    private var dropDownView = DropDownView()
    private var isDisplayDropDownView = false
    var viewModel: EventViewModel? {
        didSet {
            titleContainer.title = viewModel?.name
            timeContainerView.viewModel = viewModel
            if let alertTime = viewModel?.alertTime {
                alarmSettingsView.labelText = alertTime
            }
            if let notes = viewModel?.notes {
                notesContainerView.notes = notes
            }
            if let location = viewModel?.location {
                locationSettingsView.labelText = location
            }
        }
    }
    
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
        configureSelf()
        addSubviews()
        setupConstraints()
    }
    
    private func configureSelf() {
        self.backgroundColor = AppColor.pastelPurple
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func addSubviews() {
        addSubview(scrollView)
        scrollView.addSubview(exitButton)
        scrollView.addSubview(moreButton)
        scrollView.addSubview(editButton)
        scrollView.addSubview(titleContainer)
        scrollView.addSubview(timeContainerView)
        scrollView.addSubview(locationSettingsView)
        scrollView.addSubview(alarmSettingsView)
        scrollView.addSubview(repeatSettingsView)
        scrollView.addSubview(notesContainerView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leftAnchor.constraint(equalTo: leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            exitButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 36),
            exitButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 36)
        ])
        NSLayoutConstraint.activate([
            moreButton.centerYAnchor.constraint(equalTo: exitButton.centerYAnchor),
            moreButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -36)
        ])
        NSLayoutConstraint.activate([
            editButton.centerYAnchor.constraint(equalTo: exitButton.centerYAnchor),
            editButton.rightAnchor.constraint(equalTo: moreButton.leftAnchor, constant: -12)
        ])
        NSLayoutConstraint.activate([
            titleContainer.topAnchor.constraint(equalTo: exitButton.bottomAnchor, constant: 36),
            titleContainer.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 36),
            titleContainer.rightAnchor.constraint(equalTo: rightAnchor, constant: -36),
            titleContainer.heightAnchor.constraint(equalToConstant: 80)
        ])
        NSLayoutConstraint.activate([
            timeContainerView.topAnchor.constraint(equalTo: titleContainer.bottomAnchor, constant: -8),
            timeContainerView.leftAnchor.constraint(equalTo: leftAnchor, constant: 36),
            timeContainerView.rightAnchor.constraint(equalTo: rightAnchor, constant: -36)
        ])
        NSLayoutConstraint.activate([
            locationSettingsView.topAnchor.constraint(equalTo: timeContainerView.bottomAnchor, constant: -8),
            locationSettingsView.leftAnchor.constraint(equalTo: leftAnchor, constant: 36),
            locationSettingsView.rightAnchor.constraint(equalTo: rightAnchor, constant: -36)
        ])
        NSLayoutConstraint.activate([
            alarmSettingsView.topAnchor.constraint(equalTo: locationSettingsView.bottomAnchor, constant: -8),
            alarmSettingsView.leftAnchor.constraint(equalTo: leftAnchor, constant: 36),
            alarmSettingsView.rightAnchor.constraint(equalTo: rightAnchor, constant: -36)
        ])
        NSLayoutConstraint.activate([
            repeatSettingsView.topAnchor.constraint(equalTo: alarmSettingsView.bottomAnchor, constant: -8),
            repeatSettingsView.leftAnchor.constraint(equalTo: leftAnchor, constant: 36),
            repeatSettingsView.rightAnchor.constraint(equalTo: rightAnchor, constant: -36)
        ])
        NSLayoutConstraint.activate([
            notesContainerView.topAnchor.constraint(equalTo: repeatSettingsView.bottomAnchor, constant: -8),
            notesContainerView.leftAnchor.constraint(equalTo: leftAnchor, constant: 36),
            notesContainerView.rightAnchor.constraint(equalTo: rightAnchor, constant: -36)
        ])
    }
    
    // MARK: Selectors
    func setExitButtonSelector(selector: Selector, target: UIViewController) {
        exitButton.addTarget(target, action: selector, for: .touchUpInside)
    }
    
    func setEditButtonSelector(selector: Selector, target: UIViewController) {
        editButton.addTarget(target, action: selector, for: .touchUpInside)
    }
    
    func setMoreButtonSelector(selector: Selector, target: UIViewController) {
        moreButton.addTarget(target, action: selector, for: .touchUpInside)
    }
    
    func addDelegate(viewController: EventDetailsViewController) {
        dropDownView.delegate = viewController
    }
    
    func showOrHideDropDownMenu() {
        if !isDisplayDropDownView {
            isDisplayDropDownView = true
            self.addSubview(dropDownView)
            self.bringSubviewToFront(dropDownView)
            NSLayoutConstraint.activate([
                dropDownView.topAnchor.constraint(equalTo: editButton.bottomAnchor, constant: 6),
                 dropDownView.rightAnchor.constraint(equalTo: moreButton.rightAnchor),
                dropDownView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/3),
                dropDownView.heightAnchor.constraint(equalToConstant: dropDownView.tableView.contentSize.height + 8)
            ])
        } else {
            dismissDropDownMenu()
        }
    }
    
    func dismissDropDownMenu() {
        isDisplayDropDownView = false
        dropDownView.removeFromSuperview()
    }
}
