//
//  IconButton.swift
//  Calendar
//
//  Created by Vy Le on 5/24/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class IconButton : UIButton {
    // MARK: - Initializer
    init(name: String, size: CGFloat, color: UIColor) {
        super.init(frame: .zero)
        let configuration = UIImage.SymbolConfiguration(pointSize: size, weight: .semibold, scale: .large)
        let buttonImage = UIImage(systemName: name, withConfiguration: configuration)
        let buttonWithColor = buttonImage!.withTintColor(color, renderingMode: .alwaysOriginal)
        self.setImage(buttonWithColor, for: .normal)
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
