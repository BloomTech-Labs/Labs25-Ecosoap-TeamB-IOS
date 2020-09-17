//
//  ImpactStatsController.swift
//  labs-ios-starter
//
//  Created by Lydia Zhang on 8/11/20.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import Foundation

enum ImpactStatsQueries {
    static let impactQuery = """
    query ImpactStats($input: ImpactStatsByPropertyIdInput) {
        impactStatsByPropertyId(input: $input) {
            impactStats {
                soapRecycled
                linensRecycled
                bottlesRecycled
                paperRecycled
                peopleServed
                womenEmployed
            }
        }
    }
    """
}


class ImpactStatsController {
    
    let url = URL(string: "http://35.208.9.187:9095/ios-api-2")!
    
    func fetchImpact(id: String,
                     completion: @escaping (Result<ImpactStats, Error>) -> Void) {
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let query = ImpactStatsQueries.impactQuery
        let body: [String: Any] = ["query": query,
                                   "variables": ["input": ["propertyId": id]]]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            request.httpBody = Data()
        }

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
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
                let rawData = try JSONDecoder().decode([String: [String: [String: ImpactStats]]].self, from: data)
                let data = rawData["data"]
                if let datas = data {
                    let impact = datas["impactStatsByPropertyId"]
                    if let impactNonOp = impact {
                        let result = impactNonOp["impactStats"]
                        if let finalResult = result {
                            completion(.success(finalResult))
                        }
                    }
                }
                return
            } catch {
                NSLog("\(error)")
            }
            
        }.resume()
    }
}
