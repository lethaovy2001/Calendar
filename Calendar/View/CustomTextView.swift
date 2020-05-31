//
//  CustomTextView.swift
//  Calendar
//
//  Created by Vy Le on 5/31/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class CustomTextView: UITextView {
    private let padding = UIEdgeInsets(top: 14, left: 10, bottom: 14, right: 10)
    init(text: String) {
        super.init(frame: .zero, textContainer: nil)
        self.font = UIFont.systemFont(ofSize: 18)
        self.textColor = AppColor.gray.withAlphaComponent(0.5)
        self.backgroundColor = AppColor.inputColor
        self.text = text
        self.isScrollEnabled = false
        self.isEditable = true
        self.translatesAutoresizingMaskIntoConstraints = false

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 12
        self.textContainerInset = padding
        calculateBestHeight()
    }
    
    func setText(text: String) {
        self.text = text
    }
    
    func calculateBestHeight() {
        let size = CGSize(width: self.frame.width, height: .infinity)
        let estimatedSize = self.sizeThatFits(size)
        self.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
    }
}
