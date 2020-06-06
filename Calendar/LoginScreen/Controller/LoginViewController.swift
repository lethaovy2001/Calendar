//
//  LoginViewController.swift
//  Calendar
//
//  Created by Vy Le on 5/24/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

final class LoginViewController: UIViewController {
    // MARK: - Properties
    private let loginView = LoginView()
    private let database: Database
    private let auth: Authentication
    
    // MARK: - Initializer
    init(authentication: Authentication = FirebaseService.shared, database: Database = FirebaseService.shared) {
        self.auth = authentication
        self.database = database
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfAlreadyLogin()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // MARK: - Setup
    private func setup() {
        setupUI()
        setSelectors()
        loginView.addTapGesture(target: self, selector: #selector(dismissKeyboard))
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
    
    private func setSelectors() {
        loginView.setLoginSelector(selector: #selector(login), target: self)
    }
    
    private func checkIfAlreadyLogin() {
        if auth.getCurrentUserId() != nil {
            let viewController = DailyTaskViewController(database: self.database)
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    // MARK: - Actions
    @objc private func login() {
        guard
            let email = loginView.getEmailAddress(),
            let password = loginView.getEmailAddress()
        else { return }
        auth.createUser(email: email, password: password) { signInError in
            if let error = signInError {
                self.loginView.showError(message: error.localizedDescription)
                return
            }
            let viewController = DailyTaskViewController(database: self.database)
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
