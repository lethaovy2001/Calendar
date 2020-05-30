//
//  LabelTapGestureDelegate.swift
//  Calendar
//
//  Created by Vy Le on 5/29/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import Foundation

protocol LabelTapGestureDelegate {
    func didTap()
    func setLabel(text: String)
}

extension LabelTapGestureDelegate {
    func didTap() {
        print("Did Tap...")
    }
    
    func setLabel(text: String) {
        print("Set text to \(text)")
    }
}
