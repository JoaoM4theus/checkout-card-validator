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
        get {
            if isUsingMask {
                super.text = customMask?.formateValue(super.text ?? "") ?? super.text
                return super.text
            }
            return super.text
        }
        set {
            if isUsingMask {
                return super.text = customMask?.formateValue(newValue ?? "") ?? newValue
            }
            return super.text = newValue
        }
    }

    func updateText(string: String) {
        if isUsingMask && text?.count ?? .zero < customMask?.maskFormat.count ?? .zero - 1 {
            return super.text = customMask?.formateValue(string) ?? super.text
        }
    }
}
