//
//  SearchLocationViewController.swift
//  Calendar
//
//  Created by Vy Le on 6/18/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

final class SearchLocationViewController: UIViewController {
    // MARK: - Properties
    private let mainView = SearchLocationView()
    
    // MARK: - View Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        setup()
    }
    
    // MARK: - Setup
    private func setup() {
        setupUI()
        setupSelectors()
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
    
    private func setupSelectors() {
       
    }
    
    // MARK: Actions
}
