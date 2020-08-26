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
            updateViews()
        }
    }
    var pickupController: PickupController?
    
    @IBAction func cancelPickup(_ sender: Any) {
        if let pickupController = pickupController, let pickup = pickup {
            pickupController.cancelPickup(pickup: pickup)
        }
        navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    func updateViews() {
        guard let pickup = pickup, isViewLoaded else {return}
        readyDate.text = pickup.readyDate
        pickupDate.text = pickup.pickupDate ?? "Not avaliable yet"
        var cartonList: String = ""
        if let count = pickup.cartons?.count, count > 0 {
            for i in 0...count - 1 {
                cartonList.append(pickup.cartons![i].product)
            }
            products.text = "\(cartonList)"
        } else {
            products.text = "None"
        }
        
        confrimNum.text = pickup.confirmNum
        status.text = pickup.status
    }


}
