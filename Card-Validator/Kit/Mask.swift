//
//  Mask.swift
//  Card-Validator
//
//  Created by Joao Matheus on 15/04/23.
//

import Foundation

public protocol Mask {
    var maskFormat: String { get set }
    func formateValue(_ value: String) -> String
}

extension Mask {
    public func formateValue(_ value: String) -> String {
        let clean = value.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let mask = maskFormat
        var result = ""
        var index = clean.startIndex
        for ch in mask where index < clean.endIndex {
            if ch == "#" {
                result.append(clean[index])
                index = clean.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
}

struct PostalCodeMask: Mask {
    public var maskFormat: String = "#####-###"
    public init() { }
}

struct DocumentMask: Mask {
    public var maskFormat: String = "###.###.###-##"
    public init() { }
}

struct CreditCardNumberMask: Mask {
    public var maskFormat: String = "#### #### #### ####"
    public init() { }
}

struct CreditCardCVVMask: Mask {
    public var maskFormat: String = "###"
    public init() { }
}

struct CreditCardDueDateMask: Mask {
    public var maskFormat: String = "##/##"
    public init() { }
}
