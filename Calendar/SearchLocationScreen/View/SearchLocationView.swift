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
        let mapView = MKMapView(frame: .zero)
        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        return mapView
    }()
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.allowsMultipleSelectionDuringEditing = true
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.layer.cornerRadius = 6
        tableView.addShadow()
        return tableView
    }()
    
    // MARK: - Initializer
    init() {
        super.init(frame: .zero)
        setup()
        mapView.frame = CGRect(x: 0, y: 0, width: 450, height: 1000)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setup() {
        configureSelf()
        addSubviews()
        setupConstraints()
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
