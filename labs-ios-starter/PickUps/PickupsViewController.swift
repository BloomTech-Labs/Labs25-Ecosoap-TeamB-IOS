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
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    let userController = UserController()
    var property: Property?
    let pickupController = PickupController()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowPickupsDetail" {
            guard let detailVC = segue.destination as? PickupDetailViewController, let indexPath = tableView.indexPathForSelectedRow else {return}
            detailVC.pickupController = pickupController
            detailVC.pickup = property?.pickups?[indexPath.row]
        }
    }
}

extension PickupsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let property = property else {return 1}
        
        return property.pickups?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PickupCell", for: indexPath)
        if let property = property {
            if let pickup = property.pickups?[indexPath.row] {
                cell.textLabel?.text = pickup.confirmNum ?? "nil"
                cell.detailTextLabel?.text = pickup.status ?? "nil"
            }

        }
        
        return cell
    }
    
}

extension PickupsViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else {return}
        userController.fetchPropertyByID(id: "PropertyId1", completion: { result in
            guard let property = try? result.get() else {return}
            DispatchQueue.main.async {
                self.property = property
                self.tableView.reloadData()
            }
        })
    }
    
}
