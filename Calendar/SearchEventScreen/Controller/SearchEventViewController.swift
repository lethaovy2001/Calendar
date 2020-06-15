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
        mainView.registerCellId(viewController: self)
        mainView.setBackButtonSelector(target: self, selector: #selector(pressedBackButton))
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
    
    // MARK: Actions
    @objc private func pressedBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - UITableViewDataSource
extension SearchEventViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //TODO: remove mock data
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellId.searchedEvent,
            for: indexPath) as? SearchedEventCell
        else { return UITableViewCell() }
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SearchEventViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
