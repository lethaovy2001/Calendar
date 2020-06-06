//
//  BackButton.swift
//  Calendar
//
//  Created by Vy Le on 5/28/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

final class BackButton: IconButton {
    // MARK: - Initializer
    init() {
        super.init(name: Constants.IconNames.back, size: 24, color: AppColor.primaryColor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
