//
//  BookRingView.swift
//  Calendar
//
//  Created by Vy Le on 6/8/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

final class BookRingView: UIView {
    // MARK: - Properties
    private let leftVerticalBar: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.paleViolet
        view.layer.shadowColor = UIColor.black.withAlphaComponent(0.16).cgColor
        view.layer.shadowOffset = CGSize(width: 2.0, height: 0.0)
        view.layer.shadowOpacity = 1.0
        view.layer.shadowRadius = 2.0
        view.layer.masksToBounds = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let rightVerticalBar: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.paleViolet
        view.layer.shadowColor = UIColor.black.withAlphaComponent(0.16).cgColor
        view.layer.shadowOffset = CGSize(width: 2.0, height: 0.0)
        view.layer.shadowOpacity = 1.0
        view.layer.shadowRadius = 2.0
        view.layer.masksToBounds = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let leftCircleView = CircleView(backgroundColor: AppColor.pastelPurple)
    private let rightCircleView = CircleView(backgroundColor: AppColor.pastelPurple)
    
    // MARK: - Initializer
    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
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
        addSubview(leftCircleView)
        addSubview(leftVerticalBar)
        addSubview(rightCircleView)
        addSubview(rightVerticalBar)
        bringSubviewToFront(leftVerticalBar)
        bringSubviewToFront(rightVerticalBar)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            leftVerticalBar.topAnchor.constraint(equalTo: topAnchor),
            leftVerticalBar.leftAnchor.constraint(equalTo: leftAnchor, constant: 48),
            leftVerticalBar.widthAnchor.constraint(equalToConstant: 4),
            leftVerticalBar.heightAnchor.constraint(equalToConstant: 48)
        ])
        NSLayoutConstraint.activate([
            leftCircleView.centerYAnchor.constraint(equalTo: leftVerticalBar.bottomAnchor, constant: -2),
            leftCircleView.centerXAnchor.constraint(equalTo: leftVerticalBar.centerXAnchor),
            leftCircleView.widthAnchor.constraint(equalToConstant: 24),
            leftCircleView.heightAnchor.constraint(equalToConstant: 24)
        ])
        NSLayoutConstraint.activate([
            rightVerticalBar.topAnchor.constraint(equalTo: topAnchor),
            rightVerticalBar.rightAnchor.constraint(equalTo: rightAnchor, constant: -48),
            rightVerticalBar.widthAnchor.constraint(equalToConstant: 4),
            rightVerticalBar.heightAnchor.constraint(equalToConstant: 48)
        ])
        NSLayoutConstraint.activate([
            rightCircleView.centerYAnchor.constraint(equalTo: rightVerticalBar.bottomAnchor, constant: -2),
            rightCircleView.centerXAnchor.constraint(equalTo: rightVerticalBar.centerXAnchor),
            rightCircleView.widthAnchor.constraint(equalToConstant: 24),
            rightCircleView.heightAnchor.constraint(equalToConstant: 24)
        ])
        NSLayoutConstraint.activate([
            self.bottomAnchor.constraint(equalTo: leftCircleView.bottomAnchor),
            self.topAnchor.constraint(equalTo: leftVerticalBar.topAnchor)
        ])
    }
}
