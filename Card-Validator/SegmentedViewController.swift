//
//  ViewController.swift
//  Card-Validator
//
//  Created by Joao Matheus on 13/04/23.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    private var views: [UIView]!

    lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Endereço", "Cartão de Crédito"])
        segmentedControl.addTarget(self, action: #selector(changeView(_:)), for: .valueChanged)
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
        setupViews()
        setupConstraint()
    }
    
    private func setupViews() {
        views = [UIView]()
        [AddressViewController().view,
         CreditCardViewController().view].forEach { view in
            view?.translatesAutoresizingMaskIntoConstraints = false
            views.append(view ?? UIView())
        }
        viewContainer.addSubview(views[0])
        setupConstraintInContainer(views[0])
    }

    private func setupConstraintInContainer(_ view: UIView) {
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: viewContainer.topAnchor),
            view.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor),
            view.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor),
            view.bottomAnchor.constraint(equalTo: viewContainer.bottomAnchor)
        ])
        viewContainer.bringSubviewToFront(view)
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
    
    @objc func changeView(_ segmentedControl: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            updateView(oldView: views[1], newView: views[0])
        case 1:
            updateView(oldView: views[0], newView: views[1])
        default: break
        }
    }

    private func updateView(oldView: UIView, newView: UIView) {
        oldView.removeFromSuperview()
        viewContainer.addSubview(newView)
        setupConstraintInContainer(newView)
    }
    
    
}

