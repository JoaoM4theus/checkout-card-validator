//
//  RegisterCardViewController.swift
//  Card-Validator
//
//  Created by Joao Matheus on 13/04/23.
//

import UIKit

class RegisterCardViewController: UIViewController {

    private lazy var cardNumberTextField: CustomTextField = {
        let element = CustomTextField()
        element.isUserInteractionEnabled = true
        element.tag = 0
        element.layer.borderColor = UIColor.red.cgColor
        element.layer.cornerRadius = 9
        element.placeholder = "Número do cartão *"
        element.borderStyle = .roundedRect
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
    
    private lazy var registerCrediCardButton: UIButton = {
        let element = UIButton()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.setTitle("Registrar cartão de crédito", for: .normal)
        element.backgroundColor = .systemBlue
        element.layer.cornerRadius = 9
        element.addTarget(self, action: #selector(registerCreditCard), for: .touchUpInside)
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
        element.numberOfLines = 0
        element.adjustsFontSizeToFitWidth = true
        return element
    }()

    private var arrayTextFields: [Int: String?] = [:]
    private let viewModel = RegisterCardViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraint()
        viewModel.delegate = self
    }

    @objc private func registerCreditCard() {
        arrayTextFields = [
            cardNumberTextField.tag: cardNumberTextField.text,
            cvvNumberTextField.tag: cvvNumberTextField.text,
            dueDateTextField.tag: dueDateTextField.text,
            nameCardTextField.tag: nameCardTextField.text,
            surnameTextField.tag: surnameTextField.text
        ]
        viewModel.validateFields(array: arrayTextFields)
    }

    private func setupConstraint() {
        let lg = view.safeAreaLayoutGuide
        
        errorView.addSubview(textError)

        infoCardStackView.addArrangedSubview(dueDateTextField)
        infoCardStackView.addArrangedSubview(cvvNumberTextField)
        
        mainStackView.addArrangedSubview(cardNumberTextField)
        mainStackView.addArrangedSubview(infoCardStackView)
        mainStackView.addArrangedSubview(nameCardTextField)
        mainStackView.addArrangedSubview(surnameTextField)
        
        view.addSubview(mainStackView)
        view.addSubview(registerCrediCardButton)
        view.addSubview(errorView)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: lg.topAnchor, constant: 20),
            mainStackView.leadingAnchor.constraint(equalTo: lg.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: lg.trailingAnchor, constant: -20),
            
            registerCrediCardButton.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 18),
            registerCrediCardButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            registerCrediCardButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            registerCrediCardButton.heightAnchor.constraint(equalToConstant: 40),
            
            errorView.topAnchor.constraint(equalTo: registerCrediCardButton.bottomAnchor, constant: 20),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            errorView.heightAnchor.constraint(equalToConstant: 80),
            
            textError.centerXAnchor.constraint(equalTo: errorView.centerXAnchor),
            textError.centerYAnchor.constraint(equalTo: errorView.centerYAnchor),
            textError.leadingAnchor.constraint(equalTo: errorView.leadingAnchor, constant: 6),
            textError.trailingAnchor.constraint(equalTo: errorView.trailingAnchor, constant: -6)
        ])
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

extension RegisterCardViewController: ValidatesFields {
    
    func validateSuccess() {
        guard let surname = surnameTextField.text,
              let number = cardNumberTextField.text,
              let validate = dueDateTextField.text else { return }
        let creditCard = CreditCard(surname: surname,
                                    number: number,
                                    validate: validate)
        let viewController = CrediCardViewController(creditCard: creditCard)
        present(viewController, animated: true)
    }
    
    func validateFailedInTextField(tags: [Int]) {
        tags.forEach { tag in
            switch tag {
            case 0:
                alertErrorTextField(cardNumberTextField,
                                    message: "O número do cartão tem menos de 16 ou mais números. Por favor, digite os dados corretamente.")
            case 1:
                alertErrorTextField(cvvNumberTextField, message: "O CVV tem menos de 3 números. Por favor, digite os dados corretamente.")
            case 2:
                alertErrorTextField(dueDateTextField, message: "O vencimento informado é indevido ou cartão já passou da validade. Por favor, digite os dados corretamente.")
            case 3:
                alertErrorTextField(nameCardTextField, message: "O nome impresso do cartão está incorreto. Por favor, digite os dados corretamente.")
            case 4:
                alertErrorTextField(surnameTextField, message: "O apelido não foi preenchido. Por favor, digite os dados corretamente.")
            default: break
            }
        }
    }
}

class RegisterCardViewModel {
    
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
            case 0: // MARK: NÚMERO
                if let string = text, string != "" {
                    let correctlyString = string.replacingOccurrences(of: " ", with: "")
                    if correctlyString.count == 16 {
                        return
                    }
                }
                tags.append(tag)
                validatesSuccess = false
                return
            case 1: // MARK: CVV
                if let string = text, string != "", string.count == 3 {
                    return
                }
                tags.append(tag)
                validatesSuccess = false
                return
            case 2: // MARK: Data de vencimento
                if let string = text, string != "" {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "MM/yy"
                    if let date = dateFormatter.date(from: string) {
                        if date > Date() {
                            return
                        }
                    }
                }
                tags.append(tag)
                validatesSuccess = false
                return
            case 3: // MARK: Nome
                if let string = text, string != "" {
                    if string.components(separatedBy: " ").filter({ !$0.isEmpty}).count >= 2 {
                        return
                    }
                }
                tags.append(tag)
                validatesSuccess = false
                return
            case 4:
                if let string = text, string != "" {
                    return
                }
                tags.append(tag)
                validatesSuccess = false
                return
            default: break
            }
        }
        
        if validatesSuccess {
            delegate?.validateSuccess()
        } else {
            delegate?.validateFailedInTextField(tags: tags)
        }
    }
}

