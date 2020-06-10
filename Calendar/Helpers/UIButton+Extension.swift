//
//  UIButton+Extension.swift
//  Calendar
//
//  Created by Vy Le on 6/7/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

extension UIButton {
    func pulsate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.2
        pulse.fromValue = 0.95
        pulse.toValue = 1.0
        pulse.initialVelocity = 0.5
        pulse.damping = 1
        layer.add(pulse, forKey: nil)
    }
}
