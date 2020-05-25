//
//  CustomTextField.swift
//  Calendar
//
//  Created by Vy Le on 5/24/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class CustomTextField : UITextField {
    // MARK: - Properties
    private let padding = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
    
    // MARK: - Initializer
    init(placeholder: String, keyboardType: UIKeyboardType) {
        super.init(frame: .zero)
        self.backgroundColor = AppColor.inputColor
        self.placeholder = placeholder
        self.layer.cornerRadius = 10
        self.keyboardType = keyboardType
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
      return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
      return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
      return bounds.inset(by: padding)
    }
    
}
