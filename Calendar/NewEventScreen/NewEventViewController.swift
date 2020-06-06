//
//  NewEventViewController.swift
//  Calendar
//
//  Created by Vy Le on 5/31/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

final class NewEventViewController: UIViewController {
    // MARK: - Properties
    private var database: Database
    private let mainView = NewEventView()
    private var alertOptions = Constants.setAlertOptions
    private var selectedOption: AlertOptions?
    
    // MARK: - Initializer
    init(database: Database = FirebaseService.shared) {
        self.database = database
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Setup
    private func setup() {
        setupSelf()
        setupUI()
        registerCellId()
        setSelections()
    }
    
    private func setupSelf() {
        self.view.backgroundColor = .white
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func setupUI() {
        view.addSubview(mainView)
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.topAnchor),
            mainView.leftAnchor.constraint(equalTo: view.leftAnchor),
            mainView.rightAnchor.constraint(equalTo: view.rightAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func registerCellId() {
        mainView.registerCellId(viewController: self)
    }
    
    private func setSelections() {
        mainView.setSaveButtonSelector(target: self, selector: #selector(pressedSaveButton))
    }
    
    // MARK: Actions
    @objc private func pressedSaveButton() {
        guard let savedEvent = mainView.getSavedEvent() else {
            return
        }
        guard let time = mainView.getTimeSetForAlert() else {
            database.save(event: savedEvent)
            return
        }
        let startDate = savedEvent.startTime
        let alertDate: Date?
        var event = savedEvent
        switch selectedOption {
        case .minute:
            alertDate = Calendar.current.date(
                byAdding: .minute,
                value: -time,
                to: startDate)
            event.alertTime = alertDate
        case .hour:
            alertDate = Calendar.current.date(
                byAdding: .hour,
                value: -time,
                to: startDate)
            event.alertTime = alertDate
        case .day:
            alertDate = Calendar.current.date(
                byAdding: .day,
                value: time,
                to: startDate)
            event.alertTime = alertDate
        case .month:
            alertDate = Calendar.current.date(
                byAdding: .weekOfYear,
                value: time,
                to: startDate)
            event.alertTime = alertDate
        case .none:
            break
        }
        database.save(event: event)
    }
}

extension NewEventViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.CellId.notificationCellId,
            for: indexPath) as? NotificationCell
        else {
            return UITableViewCell()
        }
        cell.options = alertOptions[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
}

extension NewEventViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedOption = alertOptions[indexPath.row]
    }
}
