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
    private let eventLayoutGenerator = EventLayoutGenerator()
    
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
        setupSelectors()
        setDelegateAndDataSource()
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
            self.dailyTaskView.reloadEventViews()
        }
    }
    
    private func setupSelectors() {
        dailyTaskView.setCalendarButtonSelector(selector: #selector(calendarButtonPressed), target: self)
        dailyTaskView.setAddButtonSelector(selector: #selector(addButtonPressed), target: self)
        dailyTaskView.setProfileButtonSelector(selector: #selector(profileButtonPressed), target: self)
    }
    
    private func setDelegateAndDataSource() {
        dailyTaskView.setDelegateAndDataSource(viewController: self)
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

// MARK: - DailyTaskDataSource
extension DailyTaskViewController: DailyTaskDataSource {
    func numberOfEvents() -> Int {
        return modelController.getEvents().count
    }
    
    func eventView(forItemAt index: Int) -> EventView {
        let event = modelController.getEvents()[index]
        let eventView = EventView()
        let eventViewModel = EventViewModel(model: event)
        eventViewModel.configure(eventView)
        return eventView
    }
    
    func reloadData() {
        self.loadEvents()
    }
    
    func eventView(didSelectEventAt index: Int) {
        let event = modelController.getEvents()[index]
        let eventViewModel = EventViewModel(model: event)
        let viewController = EventDetailsViewController()
        viewController.viewModel = eventViewModel
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - DailyTaskDelegateFlowLayout
extension DailyTaskViewController: DailyTaskDelegateFlowLayout {
    func eventView(sizeForEventAt index: Int) -> CGSize {
        let event = modelController.getEvents()[index]
        let height = eventLayoutGenerator.estimateHeight(event: event)
        let width: CGFloat = 160
        return CGSize(width: width, height: height)
    }
    
    func eventView(topOffsetForEventAt index: Int) -> CGFloat {
        let event = modelController.getEvents()[index]
        return eventLayoutGenerator.estimateTopOffset(of: event.startTime)
    }
}

protocol DailyTaskDataSource {
    func numberOfEvents() -> Int
    func eventView(forItemAt index: Int) -> EventView
    func reloadData()
    func eventView(didSelectEventAt index: Int)
}

protocol DailyTaskDelegateFlowLayout {
    func eventView(sizeForEventAt index: Int) -> CGSize
    func eventView(topOffsetForEventAt index: Int) -> CGFloat
}
