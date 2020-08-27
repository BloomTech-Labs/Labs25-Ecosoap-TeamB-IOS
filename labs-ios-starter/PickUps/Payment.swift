//
//  Payment.swift
//  labs-ios-starter
//
//  Created by Lydia Zhang on 8/27/20.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import Foundation

enum PaymentMethod: String {
    case ach = "ACH"
    case cre = "CREDIT"
    case deb = "DEBIT"
    case wir = "WIRE"
    case oth = "OTHER"
}

struct Payment: Codable {
    let id: String?
    let amountPaid: Int?
    let amountDue: Int?
    let date: String?
    let paymentMethod: String?
}
