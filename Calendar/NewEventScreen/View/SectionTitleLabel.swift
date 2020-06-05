//
//  SectionTitleLabel.swift
//  Calendar
//
//  Created by Vy Le on 5/31/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

final class SectionTitleLabel: CustomLabel {
    init(title: String) {
        super.init(text: title, textColor: AppColor.primaryColor, textSize: 20, textWeight: .bold)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
