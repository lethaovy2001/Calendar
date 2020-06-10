//
//  TitleContainerView.swift
//  Calendar
//
//  Created by Vy Le on 6/8/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

final class TitleContainerView: CustomContainerView {
    // MARK: - Properties
    private let titleLabel = CustomLabel(text: "Title", textColor: AppColor.darkGray, textSize: 24, textWeight: .bold)
    
    // MARK: - Initializer
    override init() {
        super.init(backgroundColor: .white, cornerRadius: 20, hasShadow: true)
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
        addSubview(titleLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 24),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -24),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
