//
//  Navigator.swift
//  Calendar
//
//  Created by Vy Le on 7/16/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

protocol Navigator {
    associatedtype Destination
    
    init(navigationController: UINavigationController)
    func navigate(to destination: Destination)
}
