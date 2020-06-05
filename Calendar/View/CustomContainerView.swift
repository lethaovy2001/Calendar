//
//  CustomContainerView.swift
//  Calendar
//
//  Created by Vy Le on 5/24/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class CustomContainerView : UIView {
    // MARK: - Initializer
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    init(backgroundColor: UIColor) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    init(backgroundColor: UIColor, cornerRadius: CGFloat) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    func setCornerRadius(cornerRadius: CGFloat) {
        self.layer.cornerRadius = cornerRadius
    }
    
    func setBackgroundColor(_ color: UIColor) {
        self.backgroundColor = color
    }
}
