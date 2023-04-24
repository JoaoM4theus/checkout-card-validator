//
//  CreditCardViewController.swift
//  Card-Validator
//
//  Created by Joao Matheus on 13/04/23.
//

import UIKit

class CreditCardViewController: UIViewController {

    private lazy var cardNumberTextField: CustomTextField = {
        let element = CustomTextField()
        element.isUserInteractionEnabled = true
        element.tag = 0
        element.layer.borderColor = UIColor.red.cgColor
        element.layer.cornerRadius = 9
        element.placeholder = "Número do cartão *"
        element.borderStyle = .roundedRect
        element.delegate = self
        element.keyboardType = .numberPad
        element.customMask = CreditCardNumberMask()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    private lazy var cvvNumberTextField: CustomTextField = {
        let element = CustomTextField()
        element.isUserInteractionEnabled = true
        element.tag = 1
        element.layer.borderColor = UIColor.red.cgColor
        element.layer.cornerRadius = 9
        element.placeholder = "CVV *"
        element.borderStyle = .roundedRect
        element.delegate = self
        element.keyboardType = .numberPad
        element.customMask = CreditCardCVVMask()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var dueDateTextField: CustomTextField = {
        let element = CustomTextField()
        element.isUserInteractionEnabled = true
        element.tag = 2
        element.layer.borderColor = UIColor.red.cgColor
        element.layer.cornerRadius = 9
        element.placeholder = "Vencimento *"
        element.borderStyle = .roundedRect
        element.delegate = self
        element.keyboardType = .numberPad
        element.customMask = CreditCardDueDateMask()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var nameCardTextField: UITextField = {
        let element = CustomTextField()
        element.isUserInteractionEnabled = true
        element.tag = 3
        element.layer.borderColor = UIColor.red.cgColor
        element.layer.cornerRadius = 9
        element.placeholder = "Nome impresso *"
        element.borderStyle = .roundedRect
        element.delegate = self
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    private lazy var surnameTextField: UITextField = {
        let element = CustomTextField()
        element.isUserInteractionEnabled = true
        element.tag = 4
        element.layer.borderColor = UIColor.red.cgColor
        element.layer.cornerRadius = 9
        element.placeholder = "Apelido *"
        element.borderStyle = .roundedRect
        element.delegate = self
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    private lazy var mainStackView: UIStackView = {
        let element = UIStackView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.axis = .vertical
        element.spacing = 12
        return element
    }()
    
    private lazy var infoCardStackView: UIStackView = {
        let element = UIStackView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.axis = .horizontal
        element.spacing = 4
        element.distribution = .fillEqually
        return element
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraint()
    }

    private func setupConstraint() {
        let lg = view.safeAreaLayoutGuide
        
        infoCardStackView.addArrangedSubview(dueDateTextField)
        infoCardStackView.addArrangedSubview(cvvNumberTextField)
        
        mainStackView.addArrangedSubview(cardNumberTextField)
        mainStackView.addArrangedSubview(infoCardStackView)
        mainStackView.addArrangedSubview(nameCardTextField)
        mainStackView.addArrangedSubview(surnameTextField)
        
        view.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: lg.topAnchor, constant: 20),
            mainStackView.leadingAnchor.constraint(equalTo: lg.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: lg.trailingAnchor, constant: -20),
        ])
        
    }
}

extension CreditCardViewController: UITextFieldDelegate {
    
}
