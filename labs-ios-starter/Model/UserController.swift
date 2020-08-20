//
//  UserController.swift
//  labs-ios-starter
//
//  Created by Lydia Zhang on 8/18/20.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import Foundation

enum UserByID {
    static let user = """
    query UserbyID($input: UserByIdInput) {
        userById(input: $input) {
            user {
                id
                firstName
                lastName
                email
                phone
                address
                properties
            }
        }
    }
    """
}

enum Properties {
    static let properties = """
    query PropertiesByUserId($input:PropertiesByUserIdInput) {
        propertiesByUserId(input: $input) {
            properties {
                id
                name
            }
        }
    }
    """
}

class UserController {
    let url = URL(string: "http://35.208.9.187:9095/ios-api-2")!
    func fetchUserData(id: String, completion: @escaping (Result<User,Error>) -> ()) {
        
        var request = URLRequest(url:url)
        request.httpMethod = "POST"
        let query = UserByID.user
        let body: [String: String] = ["query": query, "variables": id]
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            NSLog("Error fetching properties: \(error)")
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) {(data, _, error) in
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
                let user = try JSONDecoder().decode(User.self, from: data)
                completion(.success((user)))
            } catch {
                NSLog("\(error)")
            }
            
        }.resume()
    }
    
    func fetchPropertiesByUser(user: User, completion: @escaping (Result<[Property],Error>) -> ()) {
        var request = URLRequest(url:url)
        request.httpMethod = "POST"
        let query = Properties.properties
        let body: [String: String] = ["query": query, "variables": user.id]
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            NSLog("Error fetching properties: \(error)")
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) {(data, _, error) in
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
                let properties = try JSONDecoder().decode([Property].self, from: data)
                completion(.success((properties)))
            } catch {
                NSLog("\(error)")
            }
            
        }.resume()
    }
}
