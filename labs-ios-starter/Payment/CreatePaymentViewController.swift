//
//  CreatePaymentViewController.swift
//  labs-ios-starter
//
//  Created by Lydia Zhang on 8/27/20.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import UIKit

class CreatePaymentViewController: UIViewController {

    
    //MARK: -UIOutlets
    @IBOutlet var idTextField: UITextField!
    @IBOutlet var dateTextField: UITextField!
    @IBOutlet var amountTextField: UITextField!
    
    @IBOutlet var ACHButton: UIButton!
    @IBOutlet var creditButton: UIButton!
    @IBOutlet var debitButton: UIButton!
    @IBOutlet var wireButton: UIButton!
    @IBOutlet var otherButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: -PAYMENT BUTTON
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
    
    
    //MARK: -DONE BUTTON
    @IBAction func doneTapped(_ sender: Any) {
    }
    
}
