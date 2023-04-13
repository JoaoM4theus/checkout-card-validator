//
//  ViewController.swift
//  Card-Validator
//
//  Created by Joao Matheus on 13/04/23.
//

import UIKit

class ViewController: UIViewController {
    
    let views = ["Item 0", "Item 1"]

    lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: views)
        segmentedControl.addTarget(self, action: #selector(printItem(_:)), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraint()
    }
    
    private func setupConstraint() {
        view.addSubview(segmentedControl)
        
        segmentedControl.center = view.center
    }
    
    @objc func printItem(_ segmentedControl: UISegmentedControl) {
        print(views[segmentedControl.selectedSegmentIndex])
    }
}

