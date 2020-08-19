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
                }
                notes
            }
        }
    }
    """
}

class PickupController {
    // MARK: - Properties
    let url = URL(string: "http://35.208.9.187:9095/ios-api-2")!

    func schedule(pickup: Pickup, completion: @escaping (Error?) -> Void = { _ in }) {
        
        let variables: [String : Any] = ["collectionType": pickup.collectionType!,
                                            "status": pickup.status!,
                                            "readyDate": pickup.readyDate!,
                                            "cartons": [["id": pickup.cartons[0].id]],
                                            "propertyId": "4"]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let mutation = Scheduling.schedule
        let body: [String : Any] = ["mutation" : mutation, "variables" : variables]
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
                print("\(response)")
            }
            completion(nil)
        }.resume()
    }
}
