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
        DispatchQueue.main.async {
            completion()
        }
    }
    
    func checkForExistingAuthenticatedUserProfile(completion: @escaping (Bool) -> Void) {
        getAuthenticatedUserProfile {
            let userID = defaults.string(forKey: "UserID")
            completion(userID != nil)
        }
    }
    
    
    func postAuthenticationExpiredNotification() {
        NotificationCenter.default.post(name: .oktaAuthenticationExpired, object: nil)
    }
}
