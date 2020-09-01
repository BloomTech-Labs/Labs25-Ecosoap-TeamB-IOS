//
//  PaymentsTableViewController.swift
//  labs-ios-starter
//
//  Created by Lydia Zhang on 8/27/20.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import UIKit

class PaymentsTableViewController: UITableViewController {

    var payments: [Payment]?
    var paymentController = PaymentController()
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViews()
    }
    
    func setupViews() {
        guard let propertyID = defaults.string(forKey: "propertyID") else { return }
        self.navigationItem.title = "Payments"
        paymentController.fetchPaymentsByPropertyID(id: propertyID, completion: { result in
            print("HI")
            guard let paymentFetched = try? result.get() else { return }
            
            DispatchQueue.main.async {
                self.payments = paymentFetched
                self.tableView.reloadData()
            }
        })
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let propertyID = defaults.string(forKey: "propertyID") else { return ""}
        return "\(propertyID)"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return payments?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentCell", for: indexPath)
        
        let payment = payments?[indexPath.row]
        cell.detailTextLabel?.text = payment?.dueDate
        cell.textLabel?.text = payment?.hospitalityContractid
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CreatePaymentSegue" {
            guard let addVC = segue.destination as? CreatePaymentViewController else { return }
            addVC.paymentController = paymentController
        } else if segue.identifier == "PaymentDetailSegue" {
            guard let detailVC = segue.destination as? PaymentDetailViewController, let indexPath = tableView.indexPathForSelectedRow else {return}
            let payment = payments?[indexPath.row]
            detailVC.payment = payment
        }
    }
    

}
