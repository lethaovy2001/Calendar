//
//  CircleView.swift
//  Calendar
//
//  Created by Vy Le on 5/29/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

final class CircleView: CustomContainerView {
    override init() {
        super.init(backgroundColor: AppColor.primaryColor)
        self.addShadow()
    }
    
    override init(backgroundColor: UIColor) {
        super.init(backgroundColor: backgroundColor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = self.frame.height / 2
    }
}
