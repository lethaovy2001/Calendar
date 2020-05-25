//
//  RoundedButton.swift
//  Calendar
//
//  Created by Vy Le on 5/24/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class RoundedButton : UIButton {
    init(title: String, color: UIColor) {
        super.init(frame: .zero)
        self.backgroundColor = color
        self.setTitle(title, for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        self.layer.masksToBounds = true
        self.addShadow()
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = self.frame.height / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
