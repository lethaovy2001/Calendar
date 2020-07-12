//
//  ViewTapGestureDelegate.swift
//  Calendar
//
//  Created by Vy Le on 7/11/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

protocol ViewTapGestureDelegate: class {
    func didTap<T: UIView>(on view: T)
}
