//
//  ProfileTabBarViewController.swift
//  labs-ios-starter
//
//  Created by Spencer Curtis on 7/31/20.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import UIKit

class ProfileTabBarViewController: UITabBarController {

    var authExpiredObserver: NSObjectProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        authExpiredObserver = NotificationCenter.default.addObserver(forName: .oktaAuthenticationExpired,
                                                                     object: nil,
                                                                     queue: .main,
                                                                     using: dismissToLogin)
    }

    deinit {
        NotificationCenter.default.removeObserver(authExpiredObserver as Any)
    }

    func dismissToLogin(_ notification: Notification) {
        dismiss(animated: true, completion: nil)
    }
}
