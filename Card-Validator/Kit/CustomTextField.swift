//
//  CustomTextField.swift
//  Card-Validator
//
//  Created by Joao Matheus on 15/04/23.
//

import UIKit

class CustomTextField: UITextField {
    var customMask: Mask? {
        didSet {
            guard let _ = customMask else {
                isUsingMask = false
                return
            }
            isUsingMask = true
        }
    }
    private var isUsingMask: Bool = false

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var text: String? {
        get { return
            super.text
        }
        set {
            if isUsingMask {
                return super.text = customMask?.formateValue(newValue ?? "") ?? newValue
            }
            return super.text = newValue
        }
    }
}
