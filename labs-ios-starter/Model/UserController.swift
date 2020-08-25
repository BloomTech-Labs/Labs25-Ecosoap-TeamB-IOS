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

enum TheProperty {
    static let theProperty = """
    query PropertyById($input: PropertyByIdInput) {
        propertyById(input: $input) {
            property {
                id
                name
                propertyType
                rooms
                services
                collectionType
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
        let body: [String : Any] = ["query": query, "variables": ["userId": id]]
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
        let body: [String : Any] = ["query": query, "variables": ["input":["userId":"\(user.id)"]]]
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
                let rawData = try JSONDecoder().decode([String:[String:[String:[Property]]]].self, from: data)
                let data = rawData["data"]
                if let datas = data {
                    let properties = datas["propertiesByUserId"]
                    if let propertiesNonOp = properties {
                        let result = propertiesNonOp["properties"]
                        if let finalResult = result {
                            completion(.success(finalResult))
                        }
                    }
                }
//                completion(.success((properties)))
            } catch {
                NSLog("\(error)")
            }
            
        }.resume()
    }
    
    func fetchPropertyByID(id: String, completion: @escaping (Result<Property,Error>) -> ()){
        var request = URLRequest(url:url)
        request.httpMethod = "POST"
        let query = TheProperty.theProperty
        let body: [String : Any] = ["query": query, "variables": ["input":["propertyId": "\(id)"]]]
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            NSLog("Error fetching properties: \(error)")
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            if let response = response {
                print(response)
            }
            if let error = error {
                NSLog("\(error)")
                completion(.failure(error))
                return
            }
            if let data = data {
                do {
                    let rawData = try JSONDecoder().decode([String:[String:[String:Property]]].self, from: data)
                    let data = rawData["data"]
                    if let propertyID = data {
                        let property = propertyID["propertyById"]
                        if let propertyNonOp = property {
                            let result = propertyNonOp["property"]
                            if let finalResult = result {
                                completion(.success(finalResult))
                            }
                        }
                    }
                    
                    //completion(.success((property)))
                } catch {
                    NSLog("\(error)")
                }
            }
            
            
            
        }.resume()
    }
}
