//
//  ProfileListViewController.swift
//  LabsScaffolding
//
//  Created by Spencer Curtis on 7/23/20.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import UIKit
import OktaAuth

protocol DropDownProtocol {
    func dropDownPressed(string: String)
}

class PickupsViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    var button = DropdownButton()
    
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
        
        button = DropdownButton.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Properties", for: .normal)
        self.view.addSubview(button)
        
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        button.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
        button.widthAnchor.constraint(equalToConstant: 500).isActive = true
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
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


class DropdownButton: UIButton, DropDownProtocol {
    
    func dropDownPressed(string: String) {
        self.setTitle(string, for: .normal)
        self.dismissDropDown()
    }
    
    func dismissDropDown() {
        isOpen = false
        NSLayoutConstraint.deactivate([self.height])
        self.height.constant = 0
        NSLayoutConstraint.activate([self.height])
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.dropdownView.center.y -= self.dropdownView.frame.height / 2
            self.dropdownView.layoutIfNeeded()
        }, completion: nil)
    }
    
    var dropdownView = DropdownView()
    var height = NSLayoutConstraint()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.lightGray
        
        dropdownView = DropdownView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        dropdownView.delegate = self
        dropdownView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func didMoveToSuperview() {
        self.superview?.addSubview(dropdownView)
        self.superview?.bringSubviewToFront(dropdownView)
        dropdownView.topAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        dropdownView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        dropdownView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        height = dropdownView.heightAnchor.constraint(equalToConstant: 0)
    }
    
    var isOpen: Bool = false
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isOpen == false {
            isOpen = true
            NSLayoutConstraint.deactivate([self.height])
            self.height.constant = 150
            NSLayoutConstraint.activate([self.height])
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                self.dropdownView.layoutIfNeeded()
            }, completion: nil)
        } else {
             isOpen = false
            NSLayoutConstraint.deactivate([self.height])
            self.height.constant = 0
            NSLayoutConstraint.activate([self.height])
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                self.dropdownView.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class DropdownView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    var dropdownOptions = [Property]()
    var tableView = UITableView()
    var delegate: DropDownProtocol!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.lightGray
        self.backgroundColor = UIColor.lightGray
        
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
        let rows = dropdownOptions.count
        return rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = dropdownOptions[indexPath.row].name ?? ""
        cell.backgroundColor = UIColor.lightGray
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate.dropDownPressed(string: dropdownOptions[indexPath.row].name ?? "")
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
