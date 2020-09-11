//
//  CreatePaymentViewController.swift
//  labs-ios-starter
//
//  Created by Lydia Zhang on 8/27/20.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import UIKit
import Stripe

class CreatePaymentViewController: UIViewController {

    // MARK: - Properites
    lazy var cardTextField: STPPaymentCardTextField = {
        let cardTextField = STPPaymentCardTextField()
        return cardTextField
    }()

    lazy var payButton: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 5
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        button.setTitle("Pay", for: .normal)
        button.addTarget(self, action: #selector(pay), for: .touchUpInside)
        return button
    }()

    lazy var idLabel: UILabel = {
        let label = UILabel()
        label.text = "Hospitality Contract ID:"
        return label
    }()

    var idTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()

    var amountLabel: UILabel = {
           let label = UILabel()
           label.text = "Amount:"
           return label
    }()

    var amountTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()

    var creditCardLabel: UILabel = {
           let label = UILabel()
           label.text = "Credit Card Details:"
           return label
    }()

    @objc
    func pay() {
        // ...
        print("pay button pressed")
    }

    // MARK: - Actions
    @IBOutlet private var dateTextField: UITextField!

    var isACH: Bool = false
    var isCredit: Bool = false
    var isDebit: Bool = false
    var isWire: Bool = false
    var isOther: Bool = false
    var paymentMethod: String = ""
    var paymentController: PaymentController?
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        let stackView = UIStackView(arrangedSubviews: [idLabel,
                                                       idTextField,
                                                       amountLabel,
                                                       amountTextField,
                                                       creditCardLabel,
                                                       cardTextField,
                                                       payButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(equalToSystemSpacingAfter: view.leftAnchor,
                                            multiplier: 2),
            view.rightAnchor.constraint(equalToSystemSpacingAfter: stackView.rightAnchor,
                                        multiplier: 2),
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor,
                                           multiplier: 2),
        ])
    }

    // MARK: - Outlets

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
        guard let amountInInt = Int(amount) else { return }
        
        paymentController.createAPayment(amount: amountInInt, date: date, paymentMehod: paymentMethod, id: id)
        navigationController?.popViewController(animated: true)
    }

    // MARK: - Private

}
