//
//  AddressViewController.swift
//  Card-Validator
//
//  Created by Joao Matheus on 13/04/23.
//

import UIKit

class AddressViewController: UIViewController {

    private lazy var mainStackView: UIStackView = {
        let element = UIStackView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.axis = .vertical
        element.spacing = 12
        return element
    }()
    
    private lazy var addressStackView: UIStackView = {
        let element = UIStackView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.axis = .horizontal
        element.spacing = 4
        element.distribution = .fillEqually
        return element
    }()
    
    private lazy var cityAndStateStackView: UIStackView = {
        let element = UIStackView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.axis = .horizontal
        element.spacing = 4
        element.distribution = .fillEqually
        return element
    }()
    
    private lazy var documentTextField: UITextField = {
        let element = UITextField()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.isUserInteractionEnabled = true
        element.placeholder = "CPF"
        element.borderStyle = .roundedRect
        return element
    }()
    
    private lazy var addressTextField: UITextField = {
        let element = UITextField()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.isUserInteractionEnabled = true
        element.placeholder = "Endereço"
        element.borderStyle = .roundedRect
        return element
    }()
    
    private lazy var addressNumberTextField: UITextField = {
        let element = UITextField()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.isUserInteractionEnabled = true
        element.placeholder = "Número de endereço"
        element.borderStyle = .roundedRect
        return element
    }()
    
    private lazy var neighborhoodTextField: UITextField = {
        let element = UITextField()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.isUserInteractionEnabled = true
        element.placeholder = "Bairro"
        element.borderStyle = .roundedRect
        return element
    }()
    
    private lazy var complementTextField: UITextField = {
        let element = UITextField()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.isUserInteractionEnabled = true
        element.placeholder = "Complemento"
        element.borderStyle = .roundedRect
        return element
    }()
    
    private lazy var postalCodeTextField: UITextField = {
        let element = UITextField()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.isUserInteractionEnabled = true
        element.placeholder = "CEP"
        element.borderStyle = .roundedRect
        return element
    }()
    
    private lazy var stateTextField: UITextField = {
        let element = UITextField()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.isUserInteractionEnabled = true
        element.placeholder = "Estado"
        element.borderStyle = .roundedRect
        return element
    }()

    private lazy var cityTextField: UITextField = {
        let element = UITextField()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.isUserInteractionEnabled = true
        element.placeholder = "Cidade"
        element.borderStyle = .roundedRect
        return element
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraint()
    }

    private func setupConstraint() {
        let lg = view.safeAreaLayoutGuide

        addressStackView.addArrangedSubview(addressNumberTextField)
        addressStackView.addArrangedSubview(complementTextField)
        
        cityAndStateStackView.addArrangedSubview(cityTextField)
        cityAndStateStackView.addArrangedSubview(stateTextField)

        [
            documentTextField,
            postalCodeTextField,
            addressTextField,
            addressStackView,
            neighborhoodTextField,
            cityAndStateStackView
        ].forEach { element in
            mainStackView.addArrangedSubview(element)
        }
        
        view.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: lg.topAnchor, constant: 20),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

}
