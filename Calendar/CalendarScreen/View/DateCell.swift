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
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
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
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            dayLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            dayLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
}
