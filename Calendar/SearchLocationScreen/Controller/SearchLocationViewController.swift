//
//  SearchLocationViewController.swift
//  Calendar
//
//  Created by Vy Le on 6/18/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

final class SearchLocationViewController: UIViewController {
    // MARK: - Properties
    private let mainView = SearchLocationView(window: UIWindow(frame: UIScreen.main.bounds))
    private let locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.allowsBackgroundLocationUpdates = false
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        return locationManager
    }()
    private var currentUserLocation: CLLocation?
    private var matchingItems: [MKMapItem] = []
    weak var delegate: ChildViewControllerDelegate?
    
    // MARK: - View Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        setup()
    }
    
    // MARK: - Private Methods
    private func setup() {
        setupUI()
        setupSelectors()
        addDelegate()
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
        mainView.setBackButtonSelector(target: self, selector: #selector(backButtonPressed))
        mainView.setSearchTextFieldSelector(target: self, selector: #selector(textFieldEditingChanged))
        mainView.setCenterButtonSelector(target: self, selector: #selector(centerUserLocation))
    }
    
    private func addDelegate() {
        locationManager.delegate = self
    }
    
    @objc private func backButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func textFieldEditingChanged() {
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
    
    @objc private func centerUserLocation() {
        guard let location = currentUserLocation else { return }
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: location.coordinate, span: span)
        mainView.mapView.setRegion(region, animated: true)
        locationManager.stopUpdatingLocation()
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
        cell.address.text = selectedItem.address
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

// MARK: - UITableViewDelegate
extension SearchLocationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = matchingItems[indexPath.row]
        delegate?.update(data: selectedItem)
        mainView.tableView.isHidden = true
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - CLLocationManagerDelegate
extension SearchLocationViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            currentUserLocation = location
            centerUserLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        default:
            break
        }
    }
}