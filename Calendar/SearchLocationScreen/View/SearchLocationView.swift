//
//  SearchLocationView.swift
//  Calendar
//
//  Created by Vy Le on 6/18/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit
import MapKit

final class SearchLocationView: UIView {
    private var containerView = CustomContainerView(backgroundColor: .white, cornerRadius: 6, hasShadow: true)
    private let backButton = IconButton(name: Constants.IconNames.back, size: 16, color: AppColor.darkGray)
    private let searchTextField = CustomTextField(placeholder: "Search", backgroundColor: .white)
    private let searchIcon = IconButton(name: Constants.IconNames.search, size: 16, color: AppColor.paleViolet)
    private let mapView: MKMapView = {
        let mapView = MKMapView(frame: CGRect(x: 0, y: 0, width: 450, height: 1000))
        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.showsUserLocation = true
        return mapView
    }()
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.allowsMultipleSelectionDuringEditing = true
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.layer.cornerRadius = 6
        tableView.addShadow()
        tableView.isHidden = true
        return tableView
    }()
    private let locationService = LocationService.shared
    
    // MARK: - Initializer
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setup() {
        configureSelf()
        addSubviews()
        setupConstraints()
        tableView.delegate = self
        tableView.dataSource = self
        searchTextField.delegate = self
        locationService.locationManager?.delegate = self
    }
    
    private func configureSelf() {
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func addSubviews() {
        addSubview(mapView)
        addSubview(tableView)
        addSubview(containerView)
        containerView.addSubview(backButton)
        containerView.addSubview(searchTextField)
        containerView.addSubview(searchIcon)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: topAnchor),
            mapView.leftAnchor.constraint(equalTo: leftAnchor),
            mapView.rightAnchor.constraint(equalTo: rightAnchor),
            mapView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 36),
            containerView.safeAreaLayoutGuide.leftAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leftAnchor,
                constant: 24),
            containerView.safeAreaLayoutGuide.rightAnchor.constraint(
                equalTo: safeAreaLayoutGuide.rightAnchor,
                constant: -24),
            containerView.heightAnchor.constraint(equalToConstant: 60)
        ])
        NSLayoutConstraint.activate([
            backButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            backButton.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 12),
            backButton.widthAnchor.constraint(equalToConstant: 24)
        ])
        NSLayoutConstraint.activate([
            searchTextField.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            searchTextField.leftAnchor.constraint(equalTo: backButton.rightAnchor),
            searchTextField.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -24)
        ])
        NSLayoutConstraint.activate([
            searchIcon.centerYAnchor.constraint(equalTo: searchTextField.centerYAnchor),
            searchIcon.rightAnchor.constraint(equalTo: searchTextField.rightAnchor),
            searchIcon.widthAnchor.constraint(equalToConstant: 24)
        ])
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 16),
            tableView.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
}

// MARK: - UITextFieldDelegate
extension SearchLocationView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        tableView.isHidden = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        tableView.isHidden = true
    }
}

// MARK: - UITableViewDelegate
extension SearchLocationView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.isHidden = true
    }
}

// MARK: - UITableViewDataSource
extension SearchLocationView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
}

// MARK: - CLLocationManagerDelegate
extension SearchLocationView: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            self.mapView.setRegion(region, animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationService.didChangeAuthorization(status: status)
    }
}
