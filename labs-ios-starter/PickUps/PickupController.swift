//
//  PickupController.swift
//  labs-ios-starter
//
//  Created by Lydia Zhang on 8/13/20.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import Foundation

enum Scheduling {
    static let schedule = """
    mutation SchedulePickup($input:SchedulePickupInput) {
        schedulePickup(input: $input) {
            pickup {
                id
                confirmationCode
                collectionType
                status
                readyDate
                pickupDate
                property
                cartons {
                    id
                    product
                    percentFull
                }
                notes
            }
        }
    }
    """
}
enum Canceling {
    static let cancel = """
    mutation CancelPickup($input: CancelPickupInput) {
        cancelPickup(input: $input) {
            pickup {
                id
                confirmationCode
            }
        }
    }
    """
}
class PickupController {
    // MARK: - Properties
    let url = URL(string: "http://35.208.9.187:9095/ios-api-2")!

    func schedule(pickup: Pickup, completion: @escaping (Error?) -> Void = { _ in }) {
        guard let collection = pickup.collectionType, let status = pickup.status, let ready = pickup.readyDate,let carton = pickup.cartons, let id = pickup.id else {return}
        var cartons: [Any] = []
        for i in 0...carton.count {
            var product: [String: Any] = [:]
            product["product"] = carton[i].product
            product["percentFull"] = carton[i].percentFull
            cartons.append(product)
        }
        let variables: [String : Any] = ["collectionType": collection,
                                            "status": status,
                                            "readyDate": ready,
                                            "cartons": cartons,
                                            "propertyId": id]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let mutation = Scheduling.schedule
        let body: [String : Any] = ["mutation" : mutation, "variables" : ["input": "\(variables)"]]
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {            
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            NSLog("Error encoding in put method: \(error)")
            completion(error)
            return
        }
        URLSession.shared.dataTask(with: request) { (_, response, error) in
            if let error = error {
                NSLog("\(error)")
                completion(error)
                return
            }
            if let response = response {
                NSLog("\(response)")
            }
            completion(nil)
        }.resume()
    }
    
    func cancelPickup(pickup: Pickup, completion: @escaping (Result<Pickup, Error>) -> Void = { _ in }) {
        guard let id = pickup.id, let conNum = pickup.confirmNum else {return}
        let variables: [String : Any] = ["pickupId": id,
                                            "confirmationCode": conNum]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let mutation = Canceling.cancel
        let body: [String : Any] = ["mutation" : mutation, "variables" : ["input": "\(variables)"]]
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            NSLog("Error encoding in put method: \(error)")
            completion(.failure(error))
            return
        }
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("\(error)")
                completion(.failure(error))
                return
            }
            guard let data = data else {
                NSLog("Data nil")
                return
            }
            
            do {
                let rawData = try JSONDecoder().decode([String:[String: [String: Pickup]]].self, from: data)
                let data = rawData["data"]
                if let datas = data {
                    let pickup = datas["cancelPickup"]
                    if let pickupNonOp = pickup {
                        let result = pickupNonOp["pickup"]
                        if let finalResult = result {
                            completion(.success(finalResult))
                        }
                    }
                }
            } catch {
                
            }
        }.resume()
    }
}
