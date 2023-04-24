//
//  AddressViewModel.swift
//  Card-Validator
//
//  Created by Joao Matheus on 24/04/23.
//

import Foundation

protocol ValidatesFields: AnyObject {
    func validateFailedInTextField(tags: [Int])
    func validateSuccess()
}

class AddressViewModel {
    
    weak var delegate: ValidatesFields?
    
    func validateFields(array: [Int: String?]) {
        var validatesSuccess: Bool = true
        var tags: [Int] = []
        
        func validate(text: String?, tag: Int) {
            if let string = text, string != "" {
                return
            }
            validatesSuccess = false
            tags.append(tag)
        }

        array.forEach { tag, text in
            switch tag {
            case 0: // MARK: CPF
                if let string = text, string.isCPF {
                    return
                }
                tags.append(tag)
                validatesSuccess = false
                return
            case 1, 2, 3, 4, 6, 7: // MARK: CEP, ENDEREÇO, NÚMERO, BAIRRO, CIDADE E ESTADO
                validate(text: text, tag: tag)
            default: break
            }
        }
        
//        if validatesSuccess {
            delegate?.validateSuccess()
//        } else {
//            delegate?.validateFailedInTextField(tags: tags)
//        }
    }
}
