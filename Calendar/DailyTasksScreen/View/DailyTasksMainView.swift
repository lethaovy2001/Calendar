//
//  DailyTasksMainView.swift
//  Calendar
//
//  Created by Vy Le on 5/25/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

final class DailyTasksMainView : UIView {
    // MARK: - Properties
    
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
        setupSelf()
        addSubViews()
        setupConstraints()
    }
    
    private func setupSelf() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func addSubViews() {

    }
    
    private func setupConstraints() {
        
    }
}

