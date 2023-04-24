//
//  AddressViewController.swift
//  Card-Validator
//
//  Created by Joao Matheus on 13/04/23.
//

import UIKit
import CoreLocation

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
        element.distribution = .fillProportionally
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
    
    private lazy var documentTextField: CustomTextField = {
        let element = CustomTextField()
        element.isUserInteractionEnabled = true
        element.tag = 0
        element.layer.borderColor = UIColor.red.cgColor
        element.layer.cornerRadius = 9
        element.placeholder = "CPF *"
        element.borderStyle = .roundedRect
        element.delegate = self
        element.keyboardType = .numberPad
        element.translatesAutoresizingMaskIntoConstraints = false
        element.customMask = DocumentMask()
        return element
    }()

    private lazy var postalCodeTextField: CustomTextField = {
        let element = CustomTextField()
        element.isUserInteractionEnabled = true
        element.tag = 1
        element.layer.borderColor = UIColor.red.cgColor
        element.layer.cornerRadius = 9
        element.placeholder = "CEP *"
        element.borderStyle = .roundedRect
        element.delegate = self
        element.keyboardType = .numberPad
        element.customMask = PostalCodeMask()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    private lazy var addressTextField: UITextField = {
        let element = UITextField()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.tag = 2
        element.layer.borderColor = UIColor.red.cgColor
        element.layer.cornerRadius = 9
        element.isUserInteractionEnabled = true
        element.placeholder = "Endereço *"
        element.borderStyle = .roundedRect
        return element
    }()
    
    private lazy var addressNumberTextField: UITextField = {
        let element = UITextField()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.tag = 3
        element.layer.borderColor = UIColor.red.cgColor
        element.layer.cornerRadius = 9
        element.isUserInteractionEnabled = true
        element.placeholder = "Número de endereço *"
        element.borderStyle = .roundedRect
        return element
    }()
    
    private lazy var neighborhoodTextField: UITextField = {
        let element = UITextField()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.tag = 4
        element.layer.borderColor = UIColor.red.cgColor
        element.layer.cornerRadius = 9
        element.isUserInteractionEnabled = true
        element.placeholder = "Bairro *"
        element.borderStyle = .roundedRect
        return element
    }()
    
    private lazy var complementTextField: UITextField = {
        let element = UITextField()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.isUserInteractionEnabled = true
        element.layer.borderColor = UIColor.red.cgColor
        element.layer.cornerRadius = 9
        element.placeholder = "Complemento"
        element.borderStyle = .roundedRect
        return element
    }()
    
    private lazy var stateTextField: UITextField = {
        let element = UITextField()
        element.isUserInteractionEnabled = true
        element.tag = 6
        element.layer.borderColor = UIColor.red.cgColor
        element.layer.cornerRadius = 9
        element.placeholder = "Estado *"
        element.borderStyle = .roundedRect
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    private lazy var cityTextField: UITextField = {
        let element = UITextField()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.tag = 7
        element.layer.borderColor = UIColor.red.cgColor
        element.layer.cornerRadius = 9
        element.isUserInteractionEnabled = true
        element.placeholder = "Cidade *"
        element.borderStyle = .roundedRect
        return element
    }()

    private lazy var goToCreditCardButton: UIButton = {
        let element = UIButton()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.setTitle("Avançar para cartão de crédito", for: .normal)
        element.backgroundColor = .systemBlue
        element.layer.cornerRadius = 9
        element.addTarget(self, action: #selector(goToCrediCard), for: .touchUpInside)
        return element
    }()

    private lazy var errorView: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.alpha = 0
        element.backgroundColor = .systemRed
        return element
    }()
    
    private lazy var textError: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.text = "Preencha os campos obrigatórios, por favor!"
        element.textColor = .white
        element.adjustsFontSizeToFitWidth = true
        return element
    }()

    private var arrayTextFields: [Int: String?] = [:]
    private let viewModel = AddressViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        view.backgroundColor = .white
        setupConstraint()
    }

    private func setupConstraint() {
        let lg = view.safeAreaLayoutGuide
        
        errorView.addSubview(textError)

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
        view.addSubview(goToCreditCardButton)
        view.addSubview(errorView)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: lg.topAnchor, constant: 20),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            goToCreditCardButton.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 18),
            goToCreditCardButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            goToCreditCardButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            goToCreditCardButton.heightAnchor.constraint(equalToConstant: 40),
            
            textError.centerXAnchor.constraint(equalTo: errorView.centerXAnchor),
            textError.centerYAnchor.constraint(equalTo: errorView.centerYAnchor),
            textError.leadingAnchor.constraint(equalTo: errorView.leadingAnchor, constant: 6),
            textError.trailingAnchor.constraint(equalTo: errorView.trailingAnchor, constant: -6),
            
            errorView.topAnchor.constraint(equalTo: goToCreditCardButton.bottomAnchor, constant: 20),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            errorView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func getLocation(postalCode: String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(postalCode) { [weak self] (placemarks, error) in
            if let placemarks = placemarks {
                print(placemarks)
                self?.cityTextField.text = placemarks.first?.locality ?? ""
                self?.stateTextField.text = placemarks.first?.administrativeArea ?? ""
                self?.neighborhoodTextField.text = placemarks.first?.subLocality ?? ""
            }
        }
    }
    
    @objc func goToCrediCard() {
        arrayTextFields = [
            documentTextField.tag: documentTextField.text,
            postalCodeTextField.tag: postalCodeTextField.text,
            addressTextField.tag: addressTextField.text,
            addressNumberTextField.tag: addressNumberTextField.text,
            neighborhoodTextField.tag: neighborhoodTextField.text,
            stateTextField.tag: stateTextField.text,
            cityTextField.tag: cityTextField.text
        ]
        viewModel.validateFields(array: arrayTextFields)
    }

    private func alertErrorTextField(_ textField: UITextField, message: String = "Preencha os campos obrigatórios, por favor!") {
        textError.text = message
        UIView.animate(withDuration: 1.5) {
            textField.layer.borderWidth = 2
            self.errorView.alpha = 1
        }
        UIView.animate(withDuration: 1.5) {
            textField.layer.borderWidth = 0
            self.errorView.alpha = 0
        }
    }
}

extension AddressViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag {
        case 1:
            getLocation(postalCode: textField.text ?? "")
        default: break
        }
    }

//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        if let textField = textField as? CustomTextField {
//            textField.updateText(string: textField.text ?? "")
//        }
//        return true
//    }
}

extension AddressViewController: ValidatesFields {
    func validateSuccess() {
        let viewController = CreditCardViewController()
        viewController.modalPresentationStyle = .pageSheet
        if let sheet = viewController.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        present(viewController, animated: true)
    }
    
    func validateFailedInTextField(tags: [Int]) {
        tags.forEach { tag in
            switch tag {
            case 0:
                alertErrorTextField(documentTextField, message: "Digite um CPF válido!")
            case 1:
                alertErrorTextField(postalCodeTextField)
            case 2:
                alertErrorTextField(addressTextField)
            case 3:
                alertErrorTextField(addressNumberTextField)
            case 4:
                alertErrorTextField(neighborhoodTextField)
            case 6:
                alertErrorTextField(stateTextField)
            case 7:
                alertErrorTextField(cityTextField)
            default: break
            }
        }
    }
}
