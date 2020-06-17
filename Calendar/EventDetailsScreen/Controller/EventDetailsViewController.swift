//
//  EventDetailsViewController.swift
//  Calendar
//
//  Created by Vy Le on 6/8/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class EventDetailsViewController: UIViewController {
    // MARK: - Properties
    private let mainView = EventDetailsView()
    var viewModel: EventViewModel? {
        didSet {
            mainView.viewModel = viewModel
        }
    }
    
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
        mainView.setEditButtonSelector(selector: #selector(pressedEditButton), target: self)
        mainView.setExitButtonSelector(selector: #selector(pressedBackButton), target: self)
        mainView.setMoreButtonSelector(selector: #selector(pressedMoreButton), target: self)
    }
    
    // MARK: Actions
    @objc private func pressedBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func pressedEditButton() {
        
    }
    
    @objc private func pressedMoreButton() {
        
    }
}
