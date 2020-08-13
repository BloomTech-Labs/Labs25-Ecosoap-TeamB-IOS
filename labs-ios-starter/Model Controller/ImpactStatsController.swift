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
    query {
        impactStats {
            soapRecycled
            linensRecycled
            bottlesRecycled
            paperRecycled
            peopleServed
            womenEmployed
        }
    }
    """
}


class ImpactStatsController {
    
    let url = URL(string: "http://35.208.9.187:9095/ios-api-2")!
    
    
    func fetchImpact(completion: @escaping (Result<ImpactStats,Error>) -> ()) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let query = ImpactStatsQueries.impactQuery
        let body = ["query": query]
        
        request.httpBody = try! JSONSerialization.data(withJSONObject: body, options: [])
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, _ , error) in
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
                let impact = try JSONDecoder().decode(ImpactStats.self, from: data)
                completion(.success(impact))
                return
            } catch {
                NSLog("\(error)")
            }
            
        }.resume()
    }
}
