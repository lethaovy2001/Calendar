//
//  EventTapGestureDelegate.swift
//  Calendar
//
//  Created by Vy Le on 6/10/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

protocol EventTapGestureDelegate: class {
    func didTap(on eventView: EventView)
}
