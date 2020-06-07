//
//  Shaking.swift
//  Calendar
//
//  Created by Vy Le on 6/6/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

protocol Shaking {
    func shake()
}

extension Shaking where Self: UIView {
    func shake() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 2
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 4, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 4, y: self.center.y))
        self.layer.add(animation, forKey: "position")
    }
}

protocol Borderable {
    func addBorder(with color: UIColor)
}

extension Borderable where Self: UIView {
    func addBorder(with color: UIColor) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = 1
    }
}
