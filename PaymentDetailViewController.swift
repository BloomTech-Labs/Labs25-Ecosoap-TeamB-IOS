//
//  PaymentDetailViewController.swift
//  labs-ios-starter
//
//  Created by Lydia Zhang on 9/1/20.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import UIKit

class PaymentDetailViewController: UIViewController {

    var payment: Payment?
    
    //MARK: -UIOutlets
    @IBOutlet var amountLabel: UILabel!
    @IBOutlet var contractLabel: UILabel!
    @IBOutlet var invoiceEndLabel: UILabel!
    @IBOutlet var invoiceStartLabel: UILabel!
    @IBOutlet var invoiceLabel: UILabel!
    @IBOutlet var paymentMethodLabel: UILabel!
    @IBOutlet var amountDueLabel: UILabel!
    @IBOutlet var paymentIDLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    func setupView() {
        guard let payment = payment else {return}
        
        amountLabel.text = "\(payment.amountPaid ?? 0)"
        contractLabel.text = payment.hospitalityContract?.id
        invoiceLabel.text = payment.invoice ?? "not avaliable"
        invoiceEndLabel.text = payment.invoicePeriodEndDate ?? "not avaliable"
        invoiceStartLabel.text = payment.invoicePeriodStartDate ?? "not avaliable"
        paymentMethodLabel.text = payment.paymentMethod ?? "not avaliable"
        amountDueLabel.text = "\(payment.amountDue ?? 0)"
        paymentIDLabel.text = payment.id
    }
}
