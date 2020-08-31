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
    
    var isACH: Bool = false
    var isCredit: Bool = false
    var isDebit: Bool = false
    var isWire: Bool = false
    var isOther: Bool = false
    var paymentMethod: String = ""
    var paymentController: PaymentController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - PAYMENT BUTTON
    @IBAction func ACHTapped(_ sender: Any) {
        isACH = true
        isCredit = false
        isDebit = false
        isWire = false
        isOther = false
    }
    @IBAction func creditTapped(_ sender: Any) {
        isACH = false
        isCredit = true
        isDebit = false
        isWire = false
        isOther = false
    }
    @IBAction func debitTapped(_ sender: Any) {
        isACH = false
        isCredit = false
        isDebit = true
        isWire = false
        isOther = false
    }
    @IBAction func wireTapped(_ sender: Any) {
        isACH = false
        isCredit = false
        isDebit = false
        isWire = true
        isOther = false
    }
    @IBAction func otherTapped(_ sender: Any) {
        isACH = false
        isCredit = false
        isDebit = false
        isWire = false
        isOther = true
    }
    
    
    // MARK: - DONE BUTTON
    @IBAction func doneTapped(_ sender: Any) {
        guard let paymentController = paymentController, let id = idTextField.text, !id.isEmpty, let date = dateTextField.text, !date.isEmpty, let amount = amountTextField.text, !amount.isEmpty else {return}
        
        if isACH {
            self.paymentMethod = PaymentMethod.ach.rawValue
        } else if isCredit {
            self.paymentMethod = PaymentMethod.cre.rawValue
        } else if isDebit {
            self.paymentMethod = PaymentMethod.deb.rawValue
        } else if isWire {
            self.paymentMethod = PaymentMethod.wir.rawValue
        } else {
            self.paymentMethod = PaymentMethod.oth.rawValue
        }
        guard paymentMethod != "" else {return}
        
        paymentController.createAPayment(amount: amount, date: date, paymentMehod: paymentMethod, id: id)
        navigationController?.popViewController(animated: true)
    }
    
}
