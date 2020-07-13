//
//  DailyTaskViewController.swift
//  Calendar
//
//  Created by Vy Le on 5/24/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class DailyTaskViewController: UIViewController {
    // MARK: - Properties
    private let dailyTaskView = DailyTasksMainView()
    private let modelController = DailyTasksModelController()
    private let database: Database
    
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
        self.view.backgroundColor = .white
        self.navigationController?.isNavigationBarHidden = true
        setup()
        loadEvents()
    }
    
    // MARK: - Setup
    private func setup() {
        setupUI()
        configureEvents()
        setupSelectors()
        addDelegate()
    }
    
    private func setupUI() {
        view.addSubview(dailyTaskView)
        NSLayoutConstraint.activate([
            dailyTaskView.topAnchor.constraint(equalTo: view.topAnchor),
            dailyTaskView.leftAnchor.constraint(equalTo: view.leftAnchor),
            dailyTaskView.rightAnchor.constraint(equalTo: view.rightAnchor),
            dailyTaskView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func loadEvents() {
        modelController.loadEvents {
            self.configureEvents()
        }
    }
    
    private func configureEvents() {
       let events = modelController.getEvents()
       for event in events {
           dailyTaskView.setEvent(event: event)
       }
    }
    
    private func setupSelectors() {
        dailyTaskView.setCalendarButtonSelector(selector: #selector(calendarButtonPressed), target: self)
        dailyTaskView.setAddButtonSelector(selector: #selector(addButtonPressed), target: self)
        dailyTaskView.setProfileButtonSelector(selector: #selector(profileButtonPressed), target: self)
    }
    
    private func addDelegate() {
        dailyTaskView.eventTapGesture = self
    }
    
    // MARK: Actions
    @objc private func calendarButtonPressed() {
        let viewController = CalendarViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc private func addButtonPressed() {
        let viewController = NewEventViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc private func profileButtonPressed() {
        let viewController = UserSettingsViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - EventTapGestureDelegate
extension DailyTaskViewController: EventTapGestureDelegate {
    func didTap(on eventView: EventView) {
        let viewController = EventDetailsViewController()
        viewController.viewModel = eventView.viewModel
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
