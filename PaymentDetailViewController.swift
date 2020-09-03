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
    
    // MARK: - UIOutlets
    @IBOutlet private var amountLabel: UILabel!
    @IBOutlet private var contractLabel: UILabel!
    @IBOutlet private var invoiceEndLabel: UILabel!
    @IBOutlet private var invoiceStartLabel: UILabel!
    @IBOutlet private var invoiceLabel: UITextView!
    @IBOutlet private var paymentMethodLabel: UILabel!
    @IBOutlet private var amountDueLabel: UILabel!
    @IBOutlet private var paymentIDLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    func setupView() {
        guard let payment = payment else { return }

        invoiceLabel.isUserInteractionEnabled = false
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
