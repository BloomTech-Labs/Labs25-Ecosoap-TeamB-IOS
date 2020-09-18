//
//  ProfileListViewController.swift
//  LabsScaffolding
//
//  Created by Spencer Curtis on 7/23/20.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import UIKit
import OktaAuth

// Swift Lint wants us to make the declation of the delegate weak
// But then that produces another error that basically requires us to
// declare the protocol with @objc
// https://stackoverflow.com/questions/33471858/swift-protocol-weak-cannot-be-applied-to-non-class-type

@objc protocol DropDownProtocol {
    func dropDownPressed(string: String)
}

@objc protocol ReloadProtocal {
    func reload()
}

public var defaults = UserDefaults.standard

class PickupsViewController: UIViewController, ReloadProtocal {
    
    func reload() {
        if let propertyId = defaults.string(forKey: "PropertyId") {
            self.button.setTitle(propertyId, for: .normal)
            
            userController.fetchPropertyByID(id: propertyId, completion: { result in
                guard let propertyFetched = try? result.get() else { return }
                DispatchQueue.main.async {
                    self.property = propertyFetched
                    self.tableView.reloadData()
                }
            })
        }
    }
    
    @IBOutlet private weak var tableView: UITableView!
    
    var button = DropdownButton()
    let userController = UserController()
    var property: Property?
    let pickupController = PickupController()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        button = DropdownButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Properties", for: .normal)
        self.view.addSubview(button)
        
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        button.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
        button.widthAnchor.constraint(equalToConstant: 500).isActive = true
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        button.dropdownView.reloadDelegate = self
        
        guard let userID = defaults.string(forKey: "UserID") else { return }
        userController.fetchPropertiesByUser(userId: userID, completion: { result in
            guard let propertiesFetched = try? result.get() else { return }
            DispatchQueue.main.async {
                self.button.dropdownView.dropdownOptions = propertiesFetched
                self.button.dropdownView.tableView.reloadData()
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let propertyId = defaults.string(forKey: "PropertyId") {
            self.button.setTitle(propertyId, for: .normal)
            userController.fetchPropertyByID(id: propertyId, completion: { result in
                guard let propertyFetched = try? result.get() else { return }
                DispatchQueue.main.async {
                    self.property = propertyFetched
                    self.tableView.reloadData()
                }
            })
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(alert), name: NSNotification.Name("MissingProperty"), object: nil)
    }
    
    @objc func alert() {
        let alert = UIAlertController(title: "Property Missing",
                                      message: "Please select a propety",
                                      preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(alertAction)
        self.present(alert, animated: true)
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
                cell.textLabel?.text = pickup.id ?? "nil"
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
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0.5,
                       options: .curveEaseInOut,
                       animations: {
            self.dropdownView.center.y -= self.dropdownView.frame.height / 2
            self.dropdownView.layoutIfNeeded()
        }, completion: nil)
    }
    
    var dropdownView = DropdownView()
    var height = NSLayoutConstraint()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.lightGray
        dropdownView = DropdownView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
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
            
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.5,
                           initialSpringVelocity: 0.5,
                           options: .curveEaseInOut,
                           animations: {
                self.dropdownView.layoutIfNeeded()
            }, completion: nil)
        } else {
            isOpen = false
            NSLayoutConstraint.deactivate([self.height])
            self.height.constant = 0
            NSLayoutConstraint.activate([self.height])
            
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.5,
                           initialSpringVelocity: 0.5,
                           options: .curveEaseInOut,
                           animations: {
                self.dropdownView.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class DropdownView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    weak var reloadDelegate: ReloadProtocal!
    var dropdownOptions = [Property]()
    var tableView = UITableView()
    weak var delegate: DropDownProtocol!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.lightGray
        tableView.isScrollEnabled = true
        self.backgroundColor = UIColor.lightGray
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableView)
        
        tableView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 50).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -50).isActive = true
        tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int { 1 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rows = dropdownOptions.count
        return rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = dropdownOptions[indexPath.row].id ?? ""
        cell.backgroundColor = UIColor.lightGray
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        self.delegate.dropDownPressed(string: dropdownOptions[indexPath.row].id ?? "")
        defaults.set(dropdownOptions[indexPath.row].id, forKey: "PropertyId")
        self.reloadDelegate.reload()
        self.tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
}
