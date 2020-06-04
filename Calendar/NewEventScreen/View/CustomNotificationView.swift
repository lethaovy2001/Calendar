//
//  CustomNotificationView.swift
//  Calendar
//
//  Created by Vy Le on 6/3/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

final class CustomNotificationView : UIView {
    // MARK: - Properties
    private let doneButton = TextButton(title: "Done", textColor: AppColor.primaryColor, textSize: 18, textWeight: .bold)
    private let containerView = CustomContainerView(backgroundColor: .white, cornerRadius: 6, hasShadow: true)
    private let title = CustomLabel(text: "CUSTOM NOTIFICATION", textColor: AppColor.darkGray, textSize: 16, textWeight: .semibold)
    private let timeTextField = CustomTextField(placeholder: "Time", keyboardType: .numberPad)
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.allowsMultipleSelectionDuringEditing = false
        tableView.allowsMultipleSelection = false
        tableView.isScrollEnabled = false
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
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
    }
    
    private func addSubviews() {
        addSubview(containerView)
        containerView.addSubview(timeTextField)
        containerView.addSubview(doneButton)
        containerView.addSubview(tableView)
        containerView.addSubview(title)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -100),
            containerView.heightAnchor.constraint(equalToConstant: 400),
            containerView.leftAnchor.constraint(equalTo: leftAnchor, constant: 36),
            containerView.rightAnchor.constraint(equalTo: rightAnchor, constant: -36)
        ])
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 24),
            title.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
        NSLayoutConstraint.activate([
            timeTextField.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 24),
            timeTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 24),
            timeTextField.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -24),
            timeTextField.heightAnchor.constraint(equalToConstant: 48)
        ])
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: timeTextField.bottomAnchor, constant: 24),
            tableView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 12),
            tableView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -12),
            tableView.heightAnchor.constraint(equalToConstant: 200)
        ])
        NSLayoutConstraint.activate([
            doneButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -24),
            doneButton.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -24),
            doneButton.widthAnchor.constraint(equalToConstant: 80)
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
    }
    
    func registerCellId(viewController: NewEventViewController) {
        tableView.dataSource = viewController
        tableView.delegate = viewController
        tableView.register(NotificationCell.self, forCellReuseIdentifier: Constants.Id.notificationCellId)
    }
}

