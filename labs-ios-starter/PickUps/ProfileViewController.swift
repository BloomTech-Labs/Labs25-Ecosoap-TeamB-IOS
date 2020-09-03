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
    var isEditClicked: Bool = false
    var userController: UserController?
    // MARK: - UIOutlets
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
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViews()
    }
    
    func setupViews() {
        guard let user = user else {return}
        idLabel.isUserInteractionEnabled = false
        firstName.isUserInteractionEnabled = false
        lastName.isUserInteractionEnabled = false
        middleName.isUserInteractionEnabled = false
        email.isUserInteractionEnabled = false
        skype.isUserInteractionEnabled = false
        phone.isUserInteractionEnabled = false
        
        idLabel.text = user.id ?? ""
        firstName.text = user.firstName ?? ""
        lastName.text = user.lasrName ?? ""
        middleName.text = user.middleName ?? ""
        email.text = user.email ?? ""
        skype.text = user.skype ?? ""
        phone.text = user.phone ?? ""
        button.title = "Edit"
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        isEditing.toggle()
        
        if isEditing {
            button.title = "Save"
            firstName.isUserInteractionEnabled = true
            lastName.isUserInteractionEnabled = true
            middleName.isUserInteractionEnabled = true
            email.isUserInteractionEnabled = true
            skype.isUserInteractionEnabled = true
            phone.isUserInteractionEnabled = true
        } else if isEditing == false {
            button.title = "Edit"
            firstName.isUserInteractionEnabled = false
            lastName.isUserInteractionEnabled = false
            middleName.isUserInteractionEnabled = false
            email.isUserInteractionEnabled = false
            skype.isUserInteractionEnabled = false
            phone.isUserInteractionEnabled = false
        }
        
    }
    

}
