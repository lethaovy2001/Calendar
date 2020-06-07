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
    private var selectedComponent: Calendar.Component?
    
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
        guard let event = mainView.getSavedEvent() else {
            return
        }
        guard
            let time = mainView.getTimeSetForAlert(),
            let component = selectedComponent,
            let alertDate = Calendar.current.date(byAdding: component,
                                                  value: -time,
                                                  to: event.startTime)
        else {
            database.save(event: event)
            return
        }
        var updateEvent = event
        updateEvent.alertTime = alertDate
        database.save(event: updateEvent)
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
        switch alertOptions[indexPath.row] {
        case .minute:
            selectedComponent = .minute
        case .hour:
            selectedComponent = .hour
        case .day:
            selectedComponent = .day
        case .month:
            selectedComponent = .month
        }
        mainView.updateAlert(option: alertOptions[indexPath.row])
    }
}
