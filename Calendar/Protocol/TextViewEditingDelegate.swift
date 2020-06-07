//
//  TextViewEditingDelegate.swift
//  Calendar
//
//  Created by Vy Le on 6/7/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

protocol TextViewEditingDelegate: class {
    func didChange()
    func beginEditing()
    func endEditing()
}
