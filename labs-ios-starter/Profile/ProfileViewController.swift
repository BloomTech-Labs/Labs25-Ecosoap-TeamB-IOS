//
//  ProfileViewController.swift
//  labs-ios-starter
//
//  Created by Lydia Zhang on 9/3/20.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    var user: User? {
        didSet {
            setupViews()
        }
    }
    var userController = UserController()

    // MARK: - UIOutlets
    @IBOutlet private var idLabel: UILabel!
    @IBOutlet private var firstName: UITextField!
    @IBOutlet private var lastName: UITextField!
    @IBOutlet private var middleName: UITextField!
    @IBOutlet private var email: UITextField!
    @IBOutlet private var skype: UITextField!
    @IBOutlet private var phone: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let userID = defaults.string(forKey: "UserID") else { return }
        // Load the user once when the view is loaded
        userController.fetchUserData(id: userID, completion: { result in
            do {
                let user = try result.get()

                DispatchQueue.main.async {
                    self.user = user
                }
            } catch {
                NSLog("viewDidLoad: fetching user info failed")
            }
        })
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViews()
    }
    
    func setupViews() {

        guard let user = user else { return }
        idLabel.text = user.id ?? ""
        firstName.text = user.firstName ?? ""
        lastName.text = user.lastName ?? ""
        middleName.text = user.middleName ?? ""
        email.text = user.email ?? ""
        skype.text = user.skype ?? ""
        phone.text = user.phone ?? ""
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        guard let firstChanged = firstName.text,
            !firstChanged.isEmpty,
            let middleChanged = middleName.text,
            let lastChanged = lastName.text,
            !lastChanged.isEmpty,
            let emailChanged = email.text,
            !emailChanged.isEmpty,
            let skypeChanged = skype.text,
            let phoneChange = phone.text,
            !phoneChange.isEmpty else { return }
        guard let userID = defaults.string(forKey: "UserID") else { return }
        userController.updateUserInfo(id: userID,
                                      firstName: firstChanged,
                                      lastName: lastChanged,
                                      middleName: middleChanged,
                                      email: emailChanged,
                                      skype: skypeChanged,
                                      phone: phoneChange,
                                      completion: { result in
            do {
                // After updating user info, grab the inforamtion from the server
                // to verify update worked.
                let userChanged = try result.get()

                DispatchQueue.main.async {
                    self.user = userChanged
                }
            } catch {
                NSLog("buttonTapped: user info update failed")
            }
        })
        
    }
    

}
