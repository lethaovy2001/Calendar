//
//  CustomButton.swift
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
