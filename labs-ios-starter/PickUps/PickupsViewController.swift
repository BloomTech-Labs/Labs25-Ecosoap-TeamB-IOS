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
            
        }
    }
}

extension PickupsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let property = property else {return 1}
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        return UITableViewCell()
    }
    
}

extension PickupsViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else {return}
        userController.fetchPropertyByID(id: searchText, completion: { result in
            guard let property = try? result.get() else {return}
            DispatchQueue.main.async {
                self.property = property
            }
        })
    }
    
}
