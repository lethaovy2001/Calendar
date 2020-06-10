//
//  CustomLabel.swift
//  Calendar
//
//  Created by Vy Le on 5/24/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class CustomLabel: UILabel {
    // MARK: - Initializer
    init(text: String, textColor: UIColor, textSize: CGFloat, textWeight: UIFont.Weight) {
        super.init(frame: .zero)
        self.backgroundColor = .clear
        self.textColor = textColor
        self.text = text
        self.textAlignment = .left
        self.font = UIFont.systemFont(ofSize: textSize, weight: textWeight)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setters
    func setText(text: String) {
        self.text = text
    }
}

extension CustomLabel: Shaking {
    func showWarningAnimation() {
        self.shake()
        self.textColor = UIColor.red
    }
}
