//
//  Updatable.swift
//  Calendar
//
//  Created by Vy Le on 6/26/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

protocol Updatable: class {
    func update<T>(value: T) 
}
