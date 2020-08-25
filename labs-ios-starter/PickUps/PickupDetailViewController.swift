//
//  PickupDetailViewController.swift
//  labs-ios-starter
//
//  Created by Lydia Zhang on 8/24/20.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import UIKit

class PickupDetailViewController: UIViewController {
    @IBOutlet var readyDate: UILabel!
    @IBOutlet var pickupDate: UILabel!
    @IBOutlet var products: UILabel!
    @IBOutlet var confrimNum: UILabel!
    @IBOutlet var status: UILabel!
    
    var pickup: Pickup? {
        didSet {
            
        }
    }
    @IBAction func cancelPickup(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func updateViews() {
        if let pickup = pickup {
            readyDate.text = pickup.readyDate
            pickupDate.text = pickup.pickupDate ?? "Not avaliable yet"
            products.text = "Service: \([pickup.cartons])"
        }
    }


}
