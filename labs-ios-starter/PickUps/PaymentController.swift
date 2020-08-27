//
//  PaymentController.swift
//  labs-ios-starter
//
//  Created by Lydia Zhang on 8/27/20.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import Foundation

enum createPayment {
    static let create = """
    mutation CreatePayment($input: CreatePaymentInput) {
        createPayment(input: $input) {
            payment{
                id
            }
        }
    }
    """
}

enum Payments {
    static let payments = """
    query paymentsByPropertyId(
    $input: PaymentsByPropertyIdInput
    ) {
        payments {
            id
            invoiceCode
            invoice
            amountPaid
            amountDue
            date
            invoicePeriodStartDate
            invoicePeriodEndDate
            dueDate
            paymentMethod
            hospitalityContract {
                id
            }
        }
    }
    """
}
