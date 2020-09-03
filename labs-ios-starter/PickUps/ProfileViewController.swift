//
//  ProfileViewController.swift
//  labs-ios-starter
//
//  Created by Lydia Zhang on 9/3/20.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    //MARK: -UIOutlets
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var firstName: UITextField!
    @IBOutlet var lastName: UITextField!
    @IBOutlet var middleName: UITextField!
    @IBOutlet var email: UITextField!
    @IBOutlet var skype: UITextField!
    @IBOutlet var phone: UITextField!
    @IBOutlet var button: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
    }
    

}
