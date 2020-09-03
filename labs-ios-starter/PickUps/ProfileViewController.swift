//
//  ProfileViewController.swift
//  labs-ios-starter
//
//  Created by Lydia Zhang on 9/3/20.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var user: User?
    var isEditClicked: Bool = false
    
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
    
    func setupViews() {
        guard let user = user else {return}
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
    }
    

}
