//
//  WeekDaysView.swift
//  Calendar
//
//  Created by Vy Le on 5/28/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

final class WeekDaysView: UIStackView {
    // MARK: - Properties
    private let weekdays = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"]
    
    // MARK: - Initializer
    init() {
        super.init(frame: .zero)
        self.axis = .horizontal
        self.distribution = .equalCentering
        self.translatesAutoresizingMaskIntoConstraints = false
        setupSubviews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupSubviews() {
        for day in weekdays {
            let label = CustomLabel(
                text: day,
                textColor: AppColor.darkGray.withAlphaComponent(0.6),
                textSize: 16,
                textWeight: .bold
            )
            label.textAlignment = .center
            self.addArrangedSubview(label)
        }
    }
}
