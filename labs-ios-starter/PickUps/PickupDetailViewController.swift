//
//  PickupDetailViewController.swift
//  labs-ios-starter
//
//  Created by Lydia Zhang on 8/24/20.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import UIKit

class PickupDetailViewController: UIViewController {
    
    @IBOutlet private var readyDate: UILabel!
    @IBOutlet private var pickupDate: UILabel!
    @IBOutlet private var products: UILabel!
    @IBOutlet private var confrimNum: UILabel!
    @IBOutlet private var status: UILabel!
    
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
        guard let pickup = pickup, isViewLoaded else { return }
        readyDate.text = pickup.readyDate
        pickupDate.text = pickup.pickupDate ?? "Not avaliable yet"
        var cartonList: String = ""

        products.text = "None"
        if let count = pickup.cartons?.count {
            // FIXME: Empty Count Violation: Prefer checking `isEmpty` over comparing `count` to zero. (empty_count)
            // if count > 0 {
                for i in 0...count - 1 {
                    cartonList.append(pickup.cartons![i].product)
                }
                products.text = "\(cartonList)"
            // }
        }
        
        confrimNum.text = pickup.confirmNum
        status.text = pickup.status
    }
}
