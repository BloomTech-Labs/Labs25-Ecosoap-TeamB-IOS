//
//  ProfileListViewController.swift
//  LabsScaffolding
//
//  Created by Spencer Curtis on 7/23/20.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import UIKit
import OktaAuth

class PickupsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let pickupController = PickupController()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    

    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowPickupsDetail" {
            
        }
    }
}

extension PickupsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        return UITableViewCell()
    }
    
}
