//
//  SearchLocationViewController.swift
//  Calendar
//
//  Created by Vy Le on 6/18/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit
import MapKit

final class SearchLocationViewController: UIViewController {
    // MARK: - Properties
    private let mainView = SearchLocationView(window: UIWindow(frame: UIScreen.main.bounds))
    private var matchingItems: [MKMapItem] = []
    
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
        mainView.addDelegateAndDataSource(viewController: self)
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
        mainView.setSearchButtonSelector(target: self, selector: #selector(searchButtonPressed))
    }
    
    // MARK: Actions
    @objc private func searchButtonPressed() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = mainView.getSearchText()
        request.region = mainView.mapView.region
        let search = MKLocalSearch(request: request)
        search.start { response, _ in
            guard let response = response else {
                return
            }
            self.matchingItems = response.mapItems
            self.mainView.tableView.isHidden = false
            self.mainView.tableView.reloadData()
        }
    }
    
    private func getAddress(from placemark: MKPlacemark) -> String {
        var addressString = ""
        if placemark.subThoroughfare != nil {
            addressString = "\(addressString + placemark.subThoroughfare!), "
        }
        if placemark.subLocality != nil {
            addressString = "\(placemark.subLocality!), "
        }
        if placemark.thoroughfare != nil {
            addressString += "\(placemark.thoroughfare!), "
        }
        if placemark.locality != nil {
            addressString += "\(placemark.locality!), "
        }
        if placemark.country != nil {
            addressString += "\(placemark.country!), "
        }
        if placemark.postalCode != nil {
            addressString += "\(placemark.postalCode!)"
        }
        return addressString
    }
}

// MARK: - UITableViewDataSource
extension SearchLocationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.matchingItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.CellId.searchedLocation,
            for: indexPath) as? SearchedLocationCell
            else { return UITableViewCell() }
        let selectedItem = matchingItems[indexPath.row]
        cell.title.text = selectedItem.name
        cell.address.text = getAddress(from: selectedItem.placemark)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}

// MARK: - UITableViewDelegate
extension SearchLocationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mainView.tableView.isHidden = true
    }
}
