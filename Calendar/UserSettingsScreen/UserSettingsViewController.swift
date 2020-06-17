//
//  UserSettingsViewController.swift
//  Calendar
//
//  Created by Vy Le on 6/10/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class UserSettingsViewController: UIViewController {
    // MARK: - Properties
    private let mainView = UserSettingsView()
    private let auth: Authentication

    // MARK: - Initializer
    init(authentication: Authentication = FirebaseService.shared) {
        self.auth = authentication
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Setup
    private func setup() {
        setupUI()
        setSelectors()
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
    
    // MARK: Selectors
    private func setSelectors() {
        mainView.setLogoutSelector(target: self, selector: #selector(logout))
        mainView.setBackButtonSelector(target: self, selector: #selector(pressedBackButton))
    }
    
    // MARK: Actions
    @objc private func logout() {
        mainView.pressedLogoutButton()
        auth.logout()
        let viewController = LoginViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc private func pressedBackButton() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
