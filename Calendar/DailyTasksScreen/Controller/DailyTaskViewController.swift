//
//  DailyTaskViewController.swift
//  Calendar
//
//  Created by Vy Le on 5/24/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class DailyTaskViewController : UIViewController {
    // MARK: - Properties
    private let dailyTaskView = DailyTasksMainView()
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
    }
    
    // MARK: - Setup
    private func setup() {
        setupUI()
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
}
