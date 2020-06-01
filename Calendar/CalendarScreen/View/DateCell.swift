//
//  DateCell.swift
//  Calendar
//
//  Created by Vy Le on 5/28/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

final class DateCell : UICollectionViewCell {
    // MARK: - Properties
    let dayLabel = CustomLabel(text: "N/A", textColor: AppColor.darkGray, textSize: 22, textWeight: .bold)
    let circleView = CircleView()
    var textColor: UIColor? {
        didSet {
            dayLabel.textColor = textColor
        }
    }
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        circleView.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup
    private func setup() {
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        addSubview(dayLabel)
        addSubview(circleView)
        bringSubviewToFront(dayLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            dayLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            dayLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
        NSLayoutConstraint.activate([
            circleView.topAnchor.constraint(equalTo: topAnchor),
            circleView.leftAnchor.constraint(equalTo: leftAnchor),
            circleView.rightAnchor.constraint(equalTo: rightAnchor),
            circleView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    func showSelectedCell() {
        circleView.isHidden = false
        dayLabel.textColor = .white
    }
    
    func hideSelectedCell() {
        circleView.isHidden = true
        dayLabel.textColor = textColor
    }
}