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
    
    // MARK: - Initializer
    init(database: Database) {
        self.database = database
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.isNavigationBarHidden = true
        setup()
    }
    
    // MARK: - Setup
    private func setup() {
        setupUI()
        registerCellId()
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
    
    private func registerCellId() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.collectionView.register(DateCell.self, forCellWithReuseIdentifier: Constants.CellId.date)
    }
}

extension CalendarViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numOfWeekdays = 7
        let numOfRows = 6
        return numOfWeekdays * numOfRows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellId.date, for: indexPath) as? DateCell else {
            return UICollectionViewCell()
        }
        cell.dayLabel.text = "10"
        return cell
    }
}

extension CalendarViewController : UICollectionViewDelegate {
    
}

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
