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
    
    @IBOutlet private weak var tableView: UITableView!
    
    
    let userController = UserController()
    var property: Property?
    let pickupController = PickupController()
    let defaults = UserDefaults.standard
    var properties: [Property]?
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        userController.fetchPropertiesByUser(userId: "UserId1", completion: { result in
            guard let propertiesFetched = try? result.get() else { return }
            DispatchQueue.main.async {
                self.properties = propertiesFetched
            }
        })
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let property = property {
            if property.id != nil {
                self.navigationItem.title = "\(property.id ?? "Eco Soap Bank")"
                userController.fetchPropertyByID(id: property.id!, completion: { result in
                    guard let propertyFetched = try? result.get() else { return }
                    DispatchQueue.main.async {
                        self.property = propertyFetched
                        self.tableView.reloadData()
                    }
                })
            }
        }
    }
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowPickupsDetail" {
            guard let detailVC = segue.destination as? PickupDetailViewController, let indexPath = tableView.indexPathForSelectedRow else { return }
            detailVC.pickupController = pickupController
            detailVC.pickup = property?.pickups?[indexPath.row]
        } else if segue.identifier == "ScheduleSegue" {
            guard let addVC = segue.destination as? SchedulePickupViewController else { return }
            addVC.property = property
            addVC.pickupController = pickupController
        }
    }
   
}

extension PickupsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let property = property else { return 1 }
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



class DropdownView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    var dropdownOptions = [Property]()
    var tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableView)
        
        tableView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dropdownOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = dropdownOptions[indexPath.row].name ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(dropdownOptions[indexPath.row].name)
    }
    
}
