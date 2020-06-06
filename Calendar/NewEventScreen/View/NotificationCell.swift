//
//  NotificationCell.swift
//  Calendar
//
//  Created by Vy Le on 6/3/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

final class NotificationCell : UITableViewCell {
    // MARK: - Properties
    private var selectedRadioButton = IconButton(
        name: Constants.IconNames.selectedRadio,
        size: 18, color: AppColor.primaryColor
    )
    private var unselectedRadioButton = IconButton(
        name: Constants.IconNames.unselectedRadio,
        size: 18, color: AppColor.gray
    )
    private let label = CustomLabel(
        text: "N/A",
        textColor: AppColor.darkGray,
        textSize: 18,
        textWeight: .regular
    )
    var options: AlertOptions? {
        didSet {
            switch options {
            case .minute:
                label.text = "Minute before"
            case .hour:
                label.text = "Hour"
            case .day:
                label.text = "Day"
            case .month:
                label.text = "Month"
            case .none:
                label.text = "N/A"
            }
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        selectedRadioButton.isHidden = true
        unselectedRadioButton.isHidden = false
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            selectedRadioButton.isHidden = false
            unselectedRadioButton.isHidden = true
        } else {
            selectedRadioButton.isHidden = true
            unselectedRadioButton.isHidden = false
        }
    }
    
    // MARK: - Setup
    private func setup() {
        addSubviews()
        setupConstraints()
        selectedRadioButton.isHidden = true
    }
    
    private func addSubviews() {
        addSubview(unselectedRadioButton)
        addSubview(selectedRadioButton)
        bringSubviewToFront(unselectedRadioButton)
        addSubview(label)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            unselectedRadioButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            unselectedRadioButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 12),
            unselectedRadioButton.heightAnchor.constraint(equalToConstant: 20),
            unselectedRadioButton.widthAnchor.constraint(equalToConstant: 20)
        ])
        NSLayoutConstraint.activate([
            selectedRadioButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            selectedRadioButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 12),
            selectedRadioButton.heightAnchor.constraint(equalToConstant: 20),
            selectedRadioButton.widthAnchor.constraint(equalToConstant: 20)
        ])
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.leftAnchor.constraint(equalTo: unselectedRadioButton.rightAnchor, constant: 16)
        ])
    }
}
