//
//  TextButton.swift
//  Calendar
//
//  Created by Vy Le on 5/28/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

final class TextButton : UIButton {
    // MARK: - Initializer
    init(title: String) {
        super.init(frame: .zero)
        self.backgroundColor = .clear
        self.setTitle(title, for: .normal)
        self.setTitleColor(.darkGray, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    init(title: String, textColor: UIColor, textSize: CGFloat, textWeight: UIFont.Weight) {
        super.init(frame: .zero)
        self.backgroundColor = .clear
        self.setTitle(title, for: .normal)
        self.setTitleColor(textColor, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: textSize, weight: textWeight)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    init(title: String, color: UIColor) {
        super.init(frame: .zero)
        self.backgroundColor = color
        self.setTitle(title, for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
