//
//  ChildViewControllerDelegate.swift
//  Calendar
//
//  Created by Vy Le on 6/26/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

protocol ChildViewControllerDelegate: class {
    func update<T>(data: T) 
}
