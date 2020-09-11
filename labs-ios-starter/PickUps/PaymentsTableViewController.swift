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
    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViews()
    }
    
    func setupViews() {
        guard let propertyID = defaults.string(forKey: "PropertyId") else {
            NotificationCenter.default.post(name: NSNotification.Name("MissingProperty"), object: self)
            return
        }
        self.navigationItem.title = "Payments"
        paymentController.fetchPaymentsByPropertyID(id: propertyID, completion: { result in
            guard let paymentFetched = try? result.get() else { return }
            DispatchQueue.main.async {
                self.payments = paymentFetched
                self.tableView.reloadData()
            }
        })
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let propertyID = defaults.string(forKey: "PropertyID") else { return "" }
        return "\(propertyID)"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return payments?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentCell", for: indexPath)
        
        let payment = payments?[indexPath.row]
        cell.detailTextLabel?.text = payment?.id
        cell.textLabel?.text = payment?.hospitalityContract?.id
        return cell
    }
    

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CreatePaymentSegue" {
            guard let addVC = segue.destination as? CreatePaymentViewController else { return }
            addVC.paymentController = paymentController
        } else if segue.identifier == "PaymentDetailSegue" {
            guard let detailVC = segue.destination as? PaymentDetailViewController, let indexPath = tableView.indexPathForSelectedRow else { return }
            let payment = payments?[indexPath.row]
            detailVC.payment = payment
        }
    }
    

}
