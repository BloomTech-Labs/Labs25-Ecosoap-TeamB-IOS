//
//  ProfileController.swift
//  LabsScaffolding
//
//  Created by Spencer Curtis on 7/23/20.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import UIKit
import OktaAuth

class ProfileController {
    
    static let shared = ProfileController()
    
    let oktaAuth = OktaAuth(baseURL: URL(string: "https://dev-668428.okta.com")!,clientID: "0oapaqacafrGUTfKx4x6",redirectURI: "labs://scaffolding/implicit/callback")
//        OktaAuth(baseURL: URL(string: "https://auth.lambdalabs.dev/")!,
//                            clientID: "0oalwkxvqtKeHBmLI4x6",
//                            redirectURI: "labs://scaffolding/implicit/callback")
    //OktaAuth(baseURL: URL(string: "https://dev-668428.okta.com")!,clientID: "0oapaqacafrGUTfKx4x6",redirectURI: "org.ecosoapbank.ESBPortal:/login")
    private(set) var authenticatedUserProfile: Profile?
  
    private let baseURL = URL(string: "https://labs-api-starter.herokuapp.com/")!
    
    func getAuthenticatedUserProfile(completion: @escaping () -> Void = { }) {
        var oktaCredentials: OktaCredentials
        
        do {
            oktaCredentials = try oktaAuth.credentialsIfAvailable()
        } catch {
            postAuthenticationExpiredNotification()
            NSLog("Credentials do not exist. Unable to get authenticated user profile from API")
            DispatchQueue.main.async {
                completion()
            }
            return
        }
        
        guard let userID = oktaCredentials.userID else {
            NSLog("User ID is missing.")
            DispatchQueue.main.async {
                completion()
            }
            return
        }
        print(userID)
        defaults.set(userID, forKey: "UserID")
        getSingleProfile(userID) { profile in
            self.authenticatedUserProfile = profile
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    func checkForExistingAuthenticatedUserProfile(completion: @escaping (Bool) -> Void) {
        getAuthenticatedUserProfile {
            completion(self.authenticatedUserProfile != nil)
        }
    }
    
    func getSingleProfile(_ userID: String,
                          completion: @escaping (Profile?) -> Void) {
        
        var oktaCredentials: OktaCredentials
        
        do {
            oktaCredentials = try oktaAuth.credentialsIfAvailable()
        } catch {
            postAuthenticationExpiredNotification()
            NSLog("Credentials do not exist. Unable to get profile from API")
            DispatchQueue.main.async {
                completion(nil)
            }
            return
        }
        
        let requestURL = baseURL
            .appendingPathComponent("profiles")
            .appendingPathComponent(userID)
        var request = URLRequest(url: requestURL)
        
        request.addValue("Bearer \(oktaCredentials.idToken)", forHTTPHeaderField: "Authorization")
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            
            var fetchedProfile: Profile?
            
            defer {
                DispatchQueue.main.async {
                    completion(fetchedProfile)
                }
            }
            
            if let error = error {
                NSLog("Error getting all profiles: \(error)")
            }
            
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                NSLog("Returned status code is not the expected 200. Instead it is \(response.statusCode)")
            }
            
            guard let data = data else {
                NSLog("No data returned from getting all profiles")
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let profile = try decoder.decode(Profile.self, from: data)
                fetchedProfile = profile
            } catch {
                NSLog("Unable to decode Profile from data: \(error)")
            }
        }
        
        dataTask.resume()
    }
    
    
    func postAuthenticationExpiredNotification() {
        NotificationCenter.default.post(name: .oktaAuthenticationExpired, object: nil)
    }
}
