//
//  UserController.swift
//  labs-ios-starter
//
//  Created by Lydia Zhang on 8/18/20.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import Foundation

enum Update {
    static let update = """
        mutation Update($input:UpdateUserProfileInput) {
            updateUserProfile(input: $input) {
                user {
                    id
                    firstName
                    lastName
                    middleName
                    email
                    password
                    phone
                    skype
                }
            }
        }
    """
}

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
                skype
                properties {
                    id
                }
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
    query PropertyByID($input: PropertyByIdInput) {
      propertyById(input: $input) {
          property {
          id
          name
          propertyType
          collectionType
          rooms
          services
          pickups {
            id
            confirmationCode
            collectionType
            status
            readyDate
            pickupDate
            cartons {
              id
              product
              percentFull
            }
            notes
          }
        }
      }
    }
    """
}

class UserController {
    let url = URL(string: "http://35.208.9.187:9095/ios-api-2")!
    
    func updateUserInfo(id: String,
                        firstName: String,
                        lastName: String,
                        middleName: String,
                        email: String,
                        skype: String,
                        phone: String,
                        completion: @escaping (Result<User, Error>) -> Void) {
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let query = Update.update
        let variable: [String: Any] = ["id": id,
                                       "firstName": firstName,
                                       "lastName": lastName,
                                       "middleName": middleName,
                                       "email": email,
                                       "skype": skype,
                                       "phone": phone]
        let body: [String: Any] = ["query": query,
                                   "variables": ["input": variable]]
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            NSLog("Error update user: \(error)")
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
                let rawData = try JSONDecoder().decode([String: [String: [String: User]]].self, from: data)
                let data = rawData["data"]
                if let datas = data {
                    let user = datas["updateUserProfile"]
                    if let userNonOp = user {
                        let result = userNonOp["user"]
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
    
    
    func fetchUserData(id: String,
                       completion: @escaping (Result<User, Error>) -> Void) {
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let query = UserByID.user
        let body: [String: Any] = ["query": query,
                                   "variables": ["input": ["userId": id]]]
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            NSLog("Error fetching properties: \(error)")
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
                let rawData = try JSONDecoder().decode([String: [String: [String: User]]].self, from: data)
                let data = rawData["data"]
                if let datas = data {
                    let user = datas["userById"]
                    if let userNonOp = user {
                        let result = userNonOp["user"]
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
    
    func fetchPropertiesByUser(userId: String,
                               completion: @escaping (Result<[Property], Error>) -> Void) {
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let query = Properties.properties
        let body: [String: Any] = ["query": query,
                                   "variables": ["input": ["userId": userId]]]
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            NSLog("Error fetching properties: \(error)")
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
                let rawData = try JSONDecoder().decode([String: [String: [String: [Property]]]].self, from: data)
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
            } catch {
                NSLog("\(error)")
            }
            
        }.resume()
    }
    
    func fetchPropertyByID(id: String,
                           completion: @escaping (Result<Property, Error>) -> Void) {
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let query = TheProperty.theProperty
        let body: [String: Any] = ["query": query,
                                   "variables": ["input": ["propertyId": id]]]
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            NSLog("Error fetching properties: \(error)")
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                NSLog("\(error)")
                completion(.failure(error))
                return
            }
            if let data = data {
                do {
                    let rawData = try JSONDecoder().decode([String: [String: [String: Property]]].self, from: data)
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

                } catch {
                    NSLog("\(error)")
                }
            }
        }.resume()
    }
}
