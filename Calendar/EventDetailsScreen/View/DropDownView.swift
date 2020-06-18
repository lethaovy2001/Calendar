//
//  DropDownView.swift
//  Calendar
//
//  Created by Vy Le on 6/17/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

final class DropDownView: CustomContainerView {
    // MARK: - Properties
    private var dropDownOptions: [EventDetailsDropDownOptions] = [.delete(event: Event())]
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.layer.masksToBounds = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    weak var delegate: DropDownProtocol?
    
    // MARK: - Initializer
    override init() {
        super.init(backgroundColor: .white, cornerRadius: 6, hasShadow: true)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setup() {
        addSubviews()
        setupConstraints()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func addSubviews() {
        addSubview(tableView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            tableView.leftAnchor.constraint(equalTo: leftAnchor, constant: 4),
            tableView.rightAnchor.constraint(equalTo: rightAnchor, constant: -4),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4)
        ])
    }
}

// MARK: - UITableViewDelegate
extension DropDownView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.dropDownPressed(on: dropDownOptions[indexPath.row])
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension DropDownView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dropDownOptions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        switch dropDownOptions[indexPath.row] {
        case .delete(_):
            cell.textLabel?.text = "Delete"
        }
        return cell
    }
}

enum EventDetailsDropDownOptions {
    case delete
}

protocol DropDownProtocol: class {
    func dropDownPressed(on option: EventDetailsDropDownOptions)
}
