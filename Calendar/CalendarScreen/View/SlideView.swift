//
//  SlideView.swift
//  Calendar
//
//  Created by Vy Le on 5/30/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

final class SlideView : CustomContainerView {
    // MARK: - Properties
    private let topBarView = CustomContainerView(backgroundColor: AppColor.gray.withAlphaComponent(0.5), cornerRadius: 2)
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.allowsMultipleSelectionDuringEditing = true
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    // MARK: - Initializer
    override init() {
        super.init(backgroundColor: .white, cornerRadius: 40)
        self.addTopShadow()
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setup() {
        addSubViews()
        setupConstraints()
    }
    
    private func addSubViews() {
        addSubview(topBarView)
        addSubview(tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            topBarView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            topBarView.centerXAnchor.constraint(equalTo: centerXAnchor),
            topBarView.heightAnchor.constraint(equalToConstant: 4),
            topBarView.widthAnchor.constraint(equalToConstant: 60)
        ])
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topBarView.bottomAnchor, constant: 24),
            tableView.leftAnchor.constraint(equalTo: leftAnchor, constant: 24),
            tableView.rightAnchor.constraint(equalTo: rightAnchor, constant: -24),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -36)
        ])
    }
    
    func registerTableViewCellId(viewController: CalendarViewController) {
        tableView.register(ScheduleCell.self, forCellReuseIdentifier: Constants.Id.scheduleCellId)
        tableView.delegate = viewController
        tableView.dataSource = viewController
        tableView.register(CustomHeaderView.self, forHeaderFooterViewReuseIdentifier: Constants.Id.sectionHeader)
    }
}
