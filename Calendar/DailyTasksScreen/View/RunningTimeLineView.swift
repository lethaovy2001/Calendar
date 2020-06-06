//
//  RunningTimeLineView.swift
//  Calendar
//
//  Created by Vy Le on 5/27/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

final class RunningTimeLineView: UIView {
    // MARK: - Properties
    private let lineView = CustomContainerView(backgroundColor: AppColor.primaryColor)
    private let circleView = CustomContainerView(
        backgroundColor: AppColor.primaryColor,
        cornerRadius: 4
    )
    
    // MARK: - Initializer
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setup() {
        addSubviews()
        setupConstraints()
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func addSubviews() {
        self.addSubview(lineView)
        self.addSubview(circleView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            circleView.centerYAnchor.constraint(equalTo: centerYAnchor),
            circleView.leftAnchor.constraint(equalTo: leftAnchor),
            circleView.widthAnchor.constraint(equalToConstant: 8),
            circleView.heightAnchor.constraint(equalToConstant: 8)
        ])
        NSLayoutConstraint.activate([
            lineView.centerYAnchor.constraint(equalTo: circleView.centerYAnchor),
            lineView.leftAnchor.constraint(equalTo: circleView.rightAnchor),
            lineView.rightAnchor.constraint(equalTo: rightAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 2)
        ])
    }
}
