//
//  ViewController.swift
//  Card-Validator
//
//  Created by Joao Matheus on 13/04/23.
//

import UIKit

class ViewController: UIViewController {
    
    private var views: [UIView]!

    lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Endereço", "Cartão de Crédito"])
        segmentedControl.addTarget(self, action: #selector(printItem(_:)), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()

    lazy var viewContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraint()
        setupViews()
    }
    
    private func setupViews() {
        views = [UIView]()
        [AddressViewController().view,
         CreditCardViewController().view].forEach { view in
            views.append(view)
        }
        views.forEach { view in
            viewContainer.addSubview(view)
        }

        viewContainer.bringSubviewToFront(views[0])
    }

    private func setupConstraint() {
        view.addSubview(segmentedControl)
        view.addSubview(viewContainer)
        
        NSLayoutConstraint.activate([
            segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),

            viewContainer.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 8),
            viewContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc func printItem(_ segmentedControl: UISegmentedControl) {
        viewContainer.bringSubviewToFront(views[segmentedControl.selectedSegmentIndex])
    }

}

