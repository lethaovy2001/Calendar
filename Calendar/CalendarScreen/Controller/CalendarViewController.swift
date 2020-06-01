//
//  CalendarViewController.swift
//  Calendar
//
//  Created by Vy Le on 5/28/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class CalendarViewController : UIViewController {
    // MARK: - Properties
    private let mainView = CalendarMainView()
    private let database: Database
    private var dateCalculator: DateCalculator
    private var selectedTodayIndexPath: IndexPath?
    private var selectedDate: Date
    private var converter: DateConverter
    
    // MARK: - Initializer
    init(database: Database) {
        self.database = database
        selectedDate = Date()
        converter = DateConverter()
        converter.convert(date: selectedDate)
        dateCalculator = DateCalculator(date: selectedDate)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Setup
    private func setup() {
        setupSelf()
        setupUI()
        registerCellId()
        setSelectors()
    }
    
    private func setupSelf() {
        self.view.backgroundColor = .white
        self.navigationController?.isNavigationBarHidden = true
    }

    private func setupUI() {
        mainView.nameOfMonth = converter.getMonthName(from: selectedDate)
        view.addSubview(mainView)
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.topAnchor),
            mainView.leftAnchor.constraint(equalTo: view.leftAnchor),
            mainView.rightAnchor.constraint(equalTo: view.rightAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func registerCellId() {
        mainView.registerCellId(viewController: self)
    }
    
    private func setSelectors() {
        mainView.setAddButtonSelector(selector: #selector(tapAddButton), target: self)
        mainView.setSearchButtonSelector(selector: #selector(tapSearchButton), target: self)
        mainView.setBackButtonSelector(selector: #selector(tapBackButton), target: self)
        mainView.setDoneButtonSelector(selector: #selector(tapDoneButton), target: self)
    }
    
    // MARK: Actions
    @objc private func tapAddButton() {
        
    }
    
    @objc private func tapSearchButton() {
        
    }
    
    @objc private func tapBackButton() {
        
    }
    
    @objc private func tapDoneButton() {
        selectedDate = mainView.getDatePickerValue()
        converter.convert(date: selectedDate)
        dateCalculator = DateCalculator(date: selectedDate)
        mainView.nameOfMonth = converter.getMonthName(from: selectedDate)
        mainView.reloadCollectionView()
        mainView.hideDatePicker()
    }
}

// MARK: - UICollectionViewDataSource
extension CalendarViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numOfWeekdays = 7
        let numOfRows = 6
        return numOfWeekdays * numOfRows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Id.dateCellId, for: indexPath) as? DateCell else { return UICollectionViewCell() }
        let date = dateCalculator.getDayString(at: indexPath.item)
        cell.dayLabel.text = date
        cell.textColor = AppColor.darkGray
        cell.hideSelectedCell()
        cell.circleView.isHidden = true
        if dateCalculator.isSelectedDate(at: indexPath.item) {
            cell.showSelectedCell()
            selectedTodayIndexPath = indexPath
        }
        if !dateCalculator.isInCurrentMonth(at: indexPath.item) {
            cell.textColor = AppColor.lightGray
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension CalendarViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let todayIndexPath = selectedTodayIndexPath {
            if let cell = collectionView.cellForItem(at: todayIndexPath) as? DateCell {
                cell.hideSelectedCell()
            }
        }
        if let cell = collectionView.cellForItem(at: indexPath) as? DateCell {
            cell.showSelectedCell()
            let newDate = dateCalculator.calculateDate(at: indexPath.item)
            mainView.setDatePickerValue(date: newDate)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? DateCell {
            cell.hideSelectedCell()
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CalendarViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfColumns: CGFloat = 7
        let cellSpacing: CGFloat = 2
        let collectionViewWidth = collectionView.frame.width
        let totalSpaceBetweenCells = cellSpacing * (numberOfColumns - 1)
        let width = collectionViewWidth/numberOfColumns - totalSpaceBetweenCells
        return CGSize(width: width, height: width)
    }
}

// MARK: - UITableViewDataSource
extension CalendarViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //TODO: remove mock data
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Id.scheduleCellId, for: indexPath) as! ScheduleCell
        return cell
    }
}

// MARK: - UITableViewDelegate
extension CalendarViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //TODO: Show details
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier:
                    Constants.Id.sectionHeader) as! CustomHeaderView
        return view
    }
}

