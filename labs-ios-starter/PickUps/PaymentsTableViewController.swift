//
//  PaymentsTableViewController.swift
//  labs-ios-starter
//
//  Created by Lydia Zhang on 8/27/20.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import UIKit

class PaymentsTableViewController: UITableViewController {

    var payments: [Payment] = []
    var paymentController = PaymentController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViews()
    }
    
    func setupViews() {
        guard let property = PickupsViewController().property else { return }
        paymentController.fetchPaymentsByPropertyID(id: property.id!, completion: { result in
            guard let paymentFetched = try? result.get() else { return }
            DispatchQueue.main.async {
                self.payments = paymentFetched
                self.tableView.reloadData()
            }
        })
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return payments.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentCell", for: indexPath)
        
        let payment = payments[indexPath.row]
        cell.detailTextLabel?.text = payment.dueDate
        cell.textLabel?.text = payment.hospitalityContractid
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
        }
    }
    

}
