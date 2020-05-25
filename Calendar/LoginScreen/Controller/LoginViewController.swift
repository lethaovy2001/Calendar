//
//  LoginViewController.swift
//  Calendar
//
//  Created by Vy Le on 5/24/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class LoginViewController : UIViewController {
    // MARK: - Properties
    private let loginView = LoginView()
    
    // MARK: - View Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Setup
    private func setup() {
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(loginView)
        view.backgroundColor = .white
        NSLayoutConstraint.activate([
            loginView.topAnchor.constraint(equalTo: view.topAnchor),
            loginView.leftAnchor.constraint(equalTo: view.leftAnchor),
            loginView.rightAnchor.constraint(equalTo: view.rightAnchor),
            loginView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
