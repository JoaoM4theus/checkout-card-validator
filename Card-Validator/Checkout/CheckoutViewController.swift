//
//  CheckoutViewController.swift
//  Card-Validator
//
//  Created by Joao Matheus on 01/05/23.
//

import UIKit

class CheckoutViewController: UIViewController {

    lazy var tableView: UITableView = {
        let element = UITableView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.delegate = self
        element.dataSource = self
        return element
    }()

    lazy var purchaseButton: UIButton = {
        let element = UIButton()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.setTitle("PAGAR", for: .normal)
        element.addTarget(self, action: #selector(didPressPurchase), for: .touchUpInside)
        return element
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @objc private func didPressPurchase() { }
}

extension CheckoutViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        .zero
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }

}
