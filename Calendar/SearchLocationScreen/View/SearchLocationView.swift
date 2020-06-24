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
    private let centerButton: TextButton = {
        let button = TextButton(
            title: "RE-CENTER",
            textColor: .systemBlue,
            textSize: 16,
            textWeight: .semibold
        )
        button.addShadow()
        button.backgroundColor = .white
        return button
    }()
    
    // MARK: - Initializer
    init(window: UIWindow) {
        super.init(frame: .zero)
        setup()
        mapView.frame = window.frame
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    private func setup() {
        configureSelf()
        addSubviews()
        setupConstraints()
        addGesture()
    }
    
    private func configureSelf() {
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func addSubviews() {
        addSubview(mapView)
        addSubview(centerButton)
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
        NSLayoutConstraint.activate([
            centerButton.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -90),
            centerButton.safeAreaLayoutGuide.leftAnchor.constraint(equalTo: leftAnchor, constant: 24),
            centerButton.widthAnchor.constraint(equalToConstant: 120),
            centerButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func addGesture() {
        let centerButtonGesture = UITapGestureRecognizer(target: self, action: #selector(centerUserLocation))
        centerButtonGesture.numberOfTapsRequired = 1
        centerButtonGesture.numberOfTouchesRequired = 1
        centerButton.addGestureRecognizer(centerButtonGesture)
    }
    
    @objc private func centerUserLocation() {
       // TODO: centerUserLocation
    }
    
    // MARK: - Public Methods
    func setBackButtonSelector(target: UIViewController, selector: Selector) {
        backButton.addTarget(target, action: selector, for: .touchUpInside)
    }
    
    func setSearchButtonSelector(target: UIViewController, selector: Selector) {
        searchIcon.addTarget(target, action: selector, for: .touchUpInside)
    }
}
