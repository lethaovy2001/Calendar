//
//  CustomHeaderView.swift
//  Calendar
//
//  Created by Vy Le on 5/31/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

final class CustomHeaderView: UITableViewHeaderFooterView {
    // MARK: - Properties
    private let title = CustomLabel(
        text: "TITLE",
        textColor: AppColor.darkGray.withAlphaComponent(0.7),
        textSize: 14,
        textWeight: .bold)
    private let dividerLine = CustomContainerView(backgroundColor: AppColor.dividerColor)
    
    // MARK: - Initializer
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = .white
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
        contentView.addSubview(title)
        contentView.addSubview(dividerLine)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: contentView.topAnchor),
            title.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            title.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
        NSLayoutConstraint.activate([
            dividerLine.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 6),
            dividerLine.heightAnchor.constraint(equalToConstant: 2),
            dividerLine.leftAnchor.constraint(equalTo: title.leftAnchor),
            dividerLine.rightAnchor.constraint(equalTo: title.rightAnchor)
        ])
    }
    
}
