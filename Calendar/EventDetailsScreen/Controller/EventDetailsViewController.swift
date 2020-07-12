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
    private let database: Database
    var viewModel: EventViewModel? {
        didSet {
            mainView.viewModel = viewModel
        }
    }
    
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
        self.navigationController?.isNavigationBarHidden = true
        setup()
    }
    
    // MARK: - Setup
    private func setup() {
        setupUI()
        setupSelectors()
        mainView.addDelegate(viewController: self)
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
        let viewController = NewEventViewController()
        viewController.viewModel = self.viewModel
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc private func pressedMoreButton() {
        mainView.showOrHideDropDownMenu()
    }
}

extension EventDetailsViewController: DropDownProtocol {
    func dropDownPressed(on option: EventDetailsDropDownOptions) {
        switch option {
        case .delete:
            viewModel?.removeEvent()
            mainView.dismissDropDownMenu()
            self.navigationController?.popViewController(animated: true)
        }
    }
}
