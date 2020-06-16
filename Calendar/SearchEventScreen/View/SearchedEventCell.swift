//
//  SearchedEventCell.swift
//  Calendar
//
//  Created by Vy Le on 6/14/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

final class SearchedEventCell: UITableViewCell {
    // MARK: - Properties
    private let eventColors = AppColor.eventColors
    private let monthLabel = CustomLabel(text: "SEP", textColor: AppColor.gray, textSize: 14, textWeight: .bold)
    private let dayLabel = CustomLabel(text: "21", textColor: AppColor.gray, textSize: 18, textWeight: .semibold)
    private let container = CustomContainerView(backgroundColor: AppColor.paleViolet, cornerRadius: 6)
    private let titleLabel = CustomLabel(text: "Title", textColor: .white, textSize: 16, textWeight: .heavy)
    private let descriptionLabel = CustomLabel(text: "N/A", textColor: .white, textSize: 16, textWeight: .bold)
    var viewModel: EventViewModel? {
        didSet {
            titleLabel.text = viewModel?.name
            descriptionLabel.text = viewModel?.shortDescription
            monthLabel.text = viewModel?.month
            dayLabel.text = viewModel?.day
        }
    }
    
    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setup() {
        addSubviews()
        setupConstraints()
        setRandomColor()
    }
    
    private func setRandomColor() {
        let randomNum = Int.random(in: 0..<eventColors.count)
        self.container.setBackgroundColor(eventColors[randomNum])
    }
    
    private func addSubviews() {
        addSubview(monthLabel)
        addSubview(dayLabel)
        addSubview(container)
        container.addSubview(titleLabel)
        container.addSubview(descriptionLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            monthLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -12),
            monthLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 24)
        ])
        NSLayoutConstraint.activate([
            dayLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 12),
            dayLabel.centerXAnchor.constraint(equalTo: monthLabel.centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            container.leftAnchor.constraint(equalTo: monthLabel.rightAnchor, constant: 12),
            container.rightAnchor.constraint(equalTo: rightAnchor, constant: -24),
            container.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            container.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
        ])
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor, constant: -12),
            titleLabel.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 24)
        ])
        NSLayoutConstraint.activate([
            descriptionLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor, constant: 12),
            descriptionLabel.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 24)
        ])
    }
}
