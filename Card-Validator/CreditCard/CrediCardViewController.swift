//
//  CrediCardViewController.swift
//  Card-Validator
//
//  Created by Joao Matheus on 25/04/23.
//

import UIKit

class CrediCardViewController: UIViewController {

    private lazy var titleLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.text = "CARTÃO REGISTRADO COM SUCESSO!"
        element.numberOfLines = 0
        element.textAlignment = .center
        return element
    }()
    
    private lazy var surnameLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.text = creditCard.surname
        element.numberOfLines = 0
        element.textAlignment = .center
        return element
    }()
    
    private lazy var validateLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.text = creditCard.validate
        element.numberOfLines = 0
        element.textAlignment = .center
        return element
    }()
    
    private lazy var numberLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.text = formattNumber(creditCard.number)
        element.numberOfLines = 0
        element.textAlignment = .center
        return element
    }()

    private lazy var mainStackView: UIStackView = {
        let element = UIStackView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.axis = .vertical
        element.spacing = 12
        element.alignment = .center
        return element
    }()
  
    private lazy var numberAndBrandStackView: UIStackView = {
        let element = UIStackView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.axis = .horizontal
        return element
    }()
    
    private lazy var brandCreditImageView: UIImageView = {
        let element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        let type = validateCreditCardFormat(text: creditCard.number)
        element.image = UIImage(named: type.imageString)
        element.heightAnchor.constraint(equalToConstant: 44).isActive = true
        element.widthAnchor.constraint(equalToConstant: 66).isActive = true
        return element
    }()
    
    private var creditCard: CreditCard

    init(creditCard: CreditCard) {
        self.creditCard = creditCard
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpConstraint()
    }

    private func setUpConstraint() {
        numberAndBrandStackView.addArrangedSubview(numberLabel)
        numberAndBrandStackView.addArrangedSubview(brandCreditImageView)
        
        mainStackView.addArrangedSubview(titleLabel)
        mainStackView.addArrangedSubview(surnameLabel)
        mainStackView.addArrangedSubview(numberAndBrandStackView)
        mainStackView.addArrangedSubview(validateLabel)
        
        view.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

    }
    
    private func formattNumber(_ text: String) -> String {
        var resultString = String()
        
        text.enumerated().forEach { (index, character) in
            if index % 4 == 0 && index > 0 {
                resultString += " "
            }
            if index < 4 || index == text.count - 2 || index == text.count - 1 {
                resultString.append(character)
            } else {
                resultString += "*"
            }
        }
        
        return resultString
    }
}

struct CreditCard {
    let surname: String
    let number: String
    let validate: String
}

extension CrediCardViewController {
    func validateCreditCardFormat(text: String) -> CardType {
        let numberOnly = text.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        
        var type: CardType = .Unknown

        for card in CardType.allCards {
            if (matchesRegex(regex: card.regex, text: numberOnly)) {
                type = card
                break
            }
        }

        return type
    }

    func matchesRegex(regex: String!, text: String!) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: regex, options: [.caseInsensitive])
            let nsString = text as NSString
            let match = regex.firstMatch(in: text, options: [], range: NSMakeRange(0, nsString.length))
            return (match != nil)
        } catch {
            return false
        }
    }
}
