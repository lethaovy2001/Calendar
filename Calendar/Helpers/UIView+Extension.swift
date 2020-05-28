//
//  UIView+Extension.swift
//  Calendar
//
//  Created by Vy Le on 5/24/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

extension UIView {
    func addShadow() {
        self.layer.shadowColor = UIColor.black.withAlphaComponent(0.16).cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 6.0
        self.layer.masksToBounds = false
    }
    
    func addTopShadow() {
        self.layer.shadowColor = UIColor.black.withAlphaComponent(0.16).cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: -3.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 6.0
        self.layer.masksToBounds = false
    }
}
