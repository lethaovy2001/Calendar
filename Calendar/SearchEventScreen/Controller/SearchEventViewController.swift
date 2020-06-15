//
//  SearchEventViewController.swift
//  Calendar
//
//  Created by Vy Le on 6/14/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

final class SearchEventViewController: UIViewController {
    // MARK: - Properties
    private let mainView = SearchEventView()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        setup()
    }
    
    // MARK: - Setup
    private func setup() {
        setupUI()
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
}
