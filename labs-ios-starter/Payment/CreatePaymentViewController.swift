//
//  CreatePaymentViewController.swift
//  labs-ios-starter
//
//  Created by Lydia Zhang on 8/27/20.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import UIKit

class CreatePaymentViewController: UIViewController {

    
    // MARK: - UIOutlets
    @IBOutlet private var idTextField: UITextField!
    @IBOutlet private var dateTextField: UITextField!
    @IBOutlet private var amountTextField: UITextField!
    
    @IBOutlet private var ACHButton: UIButton!
    @IBOutlet private var creditButton: UIButton!
    @IBOutlet private var debitButton: UIButton!
    @IBOutlet private var wireButton: UIButton!
    @IBOutlet private var otherButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - PAYMENT BUTTON
    @IBAction func ACHTapped(_ sender: Any) {
    }
    @IBAction func creditTapped(_ sender: Any) {
    }
    @IBAction func debitTapped(_ sender: Any) {
    }
    @IBAction func wireTapped(_ sender: Any) {
    }
    @IBAction func otherTapped(_ sender: Any) {
    }
    
    
    // MARK: - DONE BUTTON
    @IBAction func doneTapped(_ sender: Any) {
    }
    
}
