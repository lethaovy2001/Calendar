//
//  StringConverter.swift
//  Calendar
//
//  Created by Vy Le on 5/27/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class StringConverter {
    func convert(_ hour: Int) -> String {
        if hour < 10 {
            return "0\(hour):00"
        } else {
            return "\(hour):00"
        }
    }
}
