//
//  SearchedLocationCell.swift
//  Calendar
//
//  Created by Vy Le on 6/22/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

final class SearchedLocationCell: UITableViewCell {
    var title = CustomLabel(text: "Location", textColor: AppColor.darkGray, textSize: 18, textWeight: .semibold)
    var address = CustomLabel(text: "Address", textColor: .systemGray, textSize: 15, textWeight: .regular)
    
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
    }
    
    private func addSubviews() {
        addSubview(title)
        addSubview(address)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            title.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -12),
            title.leftAnchor.constraint(equalTo: leftAnchor, constant: 24),
            title.rightAnchor.constraint(equalTo: rightAnchor, constant: -12)
        ])
        NSLayoutConstraint.activate([
            address.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 12),
            address.leftAnchor.constraint(equalTo: leftAnchor, constant: 24),
            address.rightAnchor.constraint(equalTo: rightAnchor, constant: -12)
        ])
    }
}
