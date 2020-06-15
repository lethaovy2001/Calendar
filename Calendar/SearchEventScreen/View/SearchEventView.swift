//
//  SearchEventView.swift
//  Calendar
//
//  Created by Vy Le on 6/14/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

final class SearchEventView: UIView {
    // MARK: - Properties
    private let backButton = IconButton(name: Constants.IconNames.back, size: 18, color: AppColor.darkGray)
    private let searchTextField = CustomTextField(
        placeholder: "Search",
        backgroundColor: AppColor.pastelPurple.withAlphaComponent(0.3)
    )
    private let searchIcon = IconButton(name: Constants.IconNames.search, size: 16, color: AppColor.paleViolet)
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.allowsMultipleSelectionDuringEditing = true
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
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
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func addSubviews() {
        addSubview(backButton)
        addSubview(searchTextField)
        addSubview(searchIcon)
        addSubview(tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 36),
            backButton.safeAreaLayoutGuide.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 24),
            backButton.widthAnchor.constraint(equalToConstant: 40)
        ])
        NSLayoutConstraint.activate([
            searchTextField.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            searchTextField.leftAnchor.constraint(equalTo: backButton.rightAnchor, constant: 12),
            searchTextField.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -24)
        ])
        NSLayoutConstraint.activate([
            searchIcon.centerYAnchor.constraint(equalTo: searchTextField.centerYAnchor),
            searchIcon.rightAnchor.constraint(equalTo: searchTextField.rightAnchor, constant: -6),
            searchIcon.widthAnchor.constraint(equalToConstant: 40)
        ])
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 12),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func registerCellId(viewController: SearchEventViewController) {
        tableView.delegate = viewController
        tableView.dataSource = viewController
        tableView.register(SearchedEventCell.self, forCellReuseIdentifier: Constants.CellId.searchedEvent)
    }
    
    func setBackButtonSelector(target: UIViewController, selector: Selector) {
        backButton.addTarget(target, action: selector, for: .touchUpInside)
    }
}
