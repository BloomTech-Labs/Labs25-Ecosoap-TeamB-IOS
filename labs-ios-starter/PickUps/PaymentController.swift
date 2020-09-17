//
//  PaymentController.swift
//  labs-ios-starter
//
//  Created by Lydia Zhang on 8/27/20.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case post   = "POST"   // Create
    case get    = "GET"    // Read
    case put    = "PUT"    // Update/Replace
    case patch  = "PATCH"  // Update/Replace
    case delete = "DELETE" // Delete
}

enum CreatePayment {
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
    query paymentsByPropertyId($input: PaymentsByPropertyIdInput) {
        paymentsByPropertyId(input: $input) {
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
    }
    """
}

class PaymentController {
    let url = URL(string: "http://35.208.9.187:9095/ios-api-2")!
    
    func createAPayment(amount: Int,
                        date: String,
                        paymentMehod: String,
                        id: String,
                        completion: @escaping (Error?) -> Void = { _ in }) {
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let variable: [String: Any] = ["amountPaid": amount,
                                       "date": date,
                                       "paymentMethod": paymentMehod,
                                       "hospitalityContractId": id]
        let query = CreatePayment.create
        let body: [String: Any] = ["query": query,
                                   "variables": ["input": variable]]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            NSLog("Error creating payment")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { _, response, error in
            if let error = error {
                NSLog("\(error)")
                completion(error)
                return
            }

            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                NSLog("createAPayment: Server returned \(response.statusCode) instead of success(200).")
                completion(nil) // FIXME: What is the correct thing to return here?
            }

            print("createAPayment successful.")
            completion(nil)
        }.resume()
    }
    
    func fetchPaymentsByPropertyID(id: String,
                                   completion: @escaping (Result<[Payment], Error>) -> Void) {
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        
        let query = Payments.payments
        let body: [String: Any] = ["query": query,
                                   "variables": ["input": ["propertyId": id]]]
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            NSLog("Error fetching payments: \(error)")
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            
            if let error = error {
                NSLog("\(error)")
                completion(.failure(error))
                return
            }

            guard let data = data else {
                NSLog("Data is nil")
                return
            }
            
            do {
                let rawData = try JSONDecoder().decode([String: [String: [String: [Payment]]]].self, from: data)
                let data = rawData["data"]
                if let datas = data {
                    let payments = datas["paymentsByPropertyId"]
                    if let paymentsNonOp = payments {
                        let result = paymentsNonOp["payments"]
                        if let finalResult = result {
                            completion(.success(finalResult))
                        }
                    }
                }
            } catch {
                NSLog("\(error)")
            }
        }.resume()
    }
}
