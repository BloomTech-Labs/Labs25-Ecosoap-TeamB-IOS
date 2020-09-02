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
        ACHButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        isCredit = false
        creditButton.setImage(UIImage(systemName: "circle"), for: .normal)
        isDebit = false
        debitButton.setImage(UIImage(systemName: "circle"), for: .normal)
        isWire = false
        wireButton.setImage(UIImage(systemName: "circle"), for: .normal)
        isOther = false
        otherButton.setImage(UIImage(systemName: "circle"), for: .normal)
    }
    @IBAction func creditTapped(_ sender: Any) {
        isACH = false
        ACHButton.setImage(UIImage(systemName: "circle"), for: .normal)
        isCredit = true
        creditButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        isDebit = false
        debitButton.setImage(UIImage(systemName: "circle"), for: .normal)
        isWire = false
        wireButton.setImage(UIImage(systemName: "circle"), for: .normal)
        isOther = false
        otherButton.setImage(UIImage(systemName: "circle"), for: .normal)
    }
    @IBAction func debitTapped(_ sender: Any) {
        isACH = false
        ACHButton.setImage(UIImage(systemName: "circle"), for: .normal)
        isCredit = false
        creditButton.setImage(UIImage(systemName: "circle"), for: .normal)
        isDebit = true
        debitButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        isWire = false
        wireButton.setImage(UIImage(systemName: "circle"), for: .normal)
        isOther = false
        otherButton.setImage(UIImage(systemName: "circle"), for: .normal)
    }
    @IBAction func wireTapped(_ sender: Any) {
        isACH = false
        ACHButton.setImage(UIImage(systemName: "circle"), for: .normal)
        isCredit = false
        creditButton.setImage(UIImage(systemName: "circle"), for: .normal)
        isDebit = false
        debitButton.setImage(UIImage(systemName: "circle"), for: .normal)
        isWire = true
        wireButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        isOther = false
        otherButton.setImage(UIImage(systemName: "circle"), for: .normal)
    }
    @IBAction func otherTapped(_ sender: Any) {
        isACH = false
        ACHButton.setImage(UIImage(systemName: "circle"), for: .normal)
        isCredit = false
        creditButton.setImage(UIImage(systemName: "circle"), for: .normal)
        isDebit = false
        debitButton.setImage(UIImage(systemName: "circle"), for: .normal)
        isWire = false
        wireButton.setImage(UIImage(systemName: "circle"), for: .normal)
        isOther = true
        otherButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
    }
    
    
    // MARK: - DONE BUTTON
    @IBAction func doneTapped(_ sender: Any) {
        guard let paymentController = paymentController,
            let id = idTextField.text,
            !id.isEmpty,
            let date = dateTextField.text,
            !date.isEmpty,
            let amount = amountTextField.text,
            !amount.isEmpty else { return }
        
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
        guard paymentMethod != "" else { return }
        guard let amountInInt = Int(amount) else {return}
        
        paymentController.createAPayment(amount: amountInInt, date: date, paymentMehod: paymentMethod, id: id)
        navigationController?.popViewController(animated: true)
    }
    
}
