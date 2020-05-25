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
    private let database: Database
    
    // MARK: - Initializer
    init(database: Database) {
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
    }
}
