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

    var paymentMethod: String = ""
    var paymentController: PaymentController?

    // MARK: - Actions

    @objc
    func pay() {
        // ...
        print("pay button pressed")

        guard let paymentController = paymentController,
            let id = idTextField.text,
            !id.isEmpty,
            let amount = amountTextField.text,
            !amount.isEmpty else { return }

        guard let amountInInt = Int(amount) else { return }

        paymentController.createAPayment(amount: amountInInt,
                                         date: "2020-09-09",
                                         paymentMehod: PaymentMethod.cre.rawValue,
                                         id: id)
        
        navigationController?.popViewController(animated: true)
    }

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

    // MARK: - Private

}
