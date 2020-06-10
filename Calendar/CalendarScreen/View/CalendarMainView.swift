//
//  CalendarMainView.swift
//  Calendar
//
//  Created by Vy Le on 5/28/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

final class CalendarMainView: UIView {
    // MARK: - Properties
    private let backButton = BackButton()
    private let addButton = IconButton(
        name: Constants.IconNames.add,
        size: 24,
        color: AppColor.primaryColor
    )
    private let searchButton = IconButton(
        name: Constants.IconNames.search,
        size: 24,
        color: AppColor.primaryColor
    )
    private let monthLabel = CustomLabel(
        text: "Month",
        textColor: AppColor.darkGray,
        textSize: 30,
        textWeight: .bold
    )
    private let weekDaysView = WeekDaysView()
    private let doneButton = TextButton(title: "DONE", color: AppColor.primaryColor)
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker(frame: .zero)
        datePicker.datePickerMode = .date
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    private let containerView = CustomContainerView(
        backgroundColor: .white,
        cornerRadius: 10,
        hasShadow: true
    )
    private var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.alwaysBounceVertical = true
        collectionView.isScrollEnabled = true
        collectionView.allowsSelection = true
        collectionView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        collectionView.keyboardDismissMode = .onDrag
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    var nameOfMonth: String? {
        didSet {
            monthLabel.text = nameOfMonth
        }
    }
    private var slideView = SlideView()
    private var isShowingFullSchedule = false
    
    // MARK: - Initializer
    init() {
        super.init(frame: .zero)
        setup()
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setup() {
        addSubviews()
        setupConstraints()
        addGesture()
    }
    
    private func addGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showDatePicker))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        monthLabel.isUserInteractionEnabled = true
        monthLabel.addGestureRecognizer(tapGesture)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        slideView.isUserInteractionEnabled = true
        slideView.addGestureRecognizer(panGesture)
    }
    
    private func addSubviews() {
        addSubview(backButton)
        addSubview(addButton)
        addSubview(monthLabel)
        addSubview(searchButton)
        addSubview(collectionView)
        addSubview(weekDaysView)
        addSubview(slideView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 24),
            backButton.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            backButton.widthAnchor.constraint(equalToConstant: 30),
            backButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        NSLayoutConstraint.activate([
            monthLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            monthLabel.leftAnchor.constraint(equalTo: backButton.rightAnchor, constant: 24)
        ])
        NSLayoutConstraint.activate([
            addButton.centerYAnchor.constraint(equalTo: backButton.centerYAnchor, constant: -2),
            addButton.widthAnchor.constraint(equalToConstant: 30),
            addButton.heightAnchor.constraint(equalToConstant: 30),
            addButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -36)
        ])
        NSLayoutConstraint.activate([
            searchButton.rightAnchor.constraint(equalTo: addButton.leftAnchor, constant: -24),
            searchButton.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            searchButton.widthAnchor.constraint(equalToConstant: 30),
            searchButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        NSLayoutConstraint.activate([
            weekDaysView.topAnchor.constraint(equalTo: monthLabel.bottomAnchor, constant: 12),
            weekDaysView.leftAnchor.constraint(equalTo: leftAnchor, constant: 24),
            weekDaysView.rightAnchor.constraint(equalTo: rightAnchor, constant: -24),
            weekDaysView.heightAnchor.constraint(equalToConstant: 40)
        ])
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: weekDaysView.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor, constant: 24),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor, constant: -24),
            collectionView.heightAnchor.constraint(equalToConstant: 300)
        ])
        NSLayoutConstraint.activate([
            slideView.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            slideView.leftAnchor.constraint(equalTo: leftAnchor),
            slideView.rightAnchor.constraint(equalTo: rightAnchor),
            slideView.heightAnchor.constraint(equalTo: heightAnchor, constant: -100)
        ])
    }
    
    // MARK: Selectors
    func setBackButtonSelector(selector: Selector, target: UIViewController) {
        backButton.addTarget(target, action: selector, for: .touchUpInside)
    }
    
    func setAddButtonSelector(selector: Selector, target: UIViewController) {
        addButton.addTarget(target, action: selector, for: .touchUpInside)
    }
    
    func setSearchButtonSelector(selector: Selector, target: UIViewController) {
        searchButton.addTarget(target, action: selector, for: .touchUpInside)
    }
    
    func setDoneButtonSelector(selector: Selector, target: UIViewController) {
        doneButton.addTarget(target, action: selector, for: .touchUpInside)
    }
    
    // MARK: Actions
    @objc private func showDatePicker() {
        addSubview(containerView)
        containerView.addSubview(datePicker)
        containerView.addSubview(doneButton)
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 300),
            containerView.leftAnchor.constraint(equalTo: leftAnchor, constant: 36),
            containerView.rightAnchor.constraint(equalTo: rightAnchor, constant: -36)
        ])
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: containerView.topAnchor),
            datePicker.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            doneButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: -12),
            doneButton.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16),
            doneButton.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16),
            doneButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            doneButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    func hideDatePicker() {
        containerView.removeFromSuperview()
        datePicker.removeFromSuperview()
        doneButton.removeFromSuperview()
    }
    
    func getDatePickerValue() -> Date {
        return datePicker.date
    }
    
    func setDatePickerValue(date: Date) {
        datePicker.setDate(date, animated: true)
    }
    
    func registerCellId(viewController: CalendarViewController) {
        slideView.registerTableViewCellId(viewController: viewController)
        collectionView.delegate = viewController
        collectionView.dataSource = viewController
        collectionView.register(DateCell.self, forCellWithReuseIdentifier: Constants.CellId.dateCellId)
    }
    
    func reloadCollectionView() {
        collectionView.reloadData()
    }
    
    func reloadTableView() {
        slideView.reloadTableView()
    }
    
    @objc private func handlePanGesture() {
        if !isShowingFullSchedule {
            UIView.animate(withDuration: 0.6) {
                self.slideView.frame.origin.y = 100
                
            }
        } else {
            UIView.animate(withDuration: 0.6) {
                self.slideView.frame.origin.y = 475
            }
        }
        isShowingFullSchedule = !isShowingFullSchedule
    }
}
