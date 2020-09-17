//
//  SchedulePickupViewController.swift
//  labs-ios-starter
//
//  Created by Lydia Zhang on 8/25/20.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import UIKit

class SchedulePickupViewController: UIViewController {
    
    @IBOutlet private var datePicker: UIDatePicker!
    @IBOutlet private var bottleTextField: UITextField!
    @IBOutlet private var linenTextField: UITextField!
    @IBOutlet private var otherTextField: UITextField!
    @IBOutlet private var soapTextField: UITextField!
    @IBOutlet private var paperTextField: UITextField!
    
    var pickupController: PickupController?
    var property: Property?
    
    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func schedulePressed(_ sender: Any) {
        
        guard let pickupController = pickupController, let property = property else { return }
        var cartons = [[String: Any]]()
        
        let date = datePicker.date
        let dateStr = dateFormatter.string(from: date)
        
        if let bottle = bottleTextField.text, !bottle.isEmpty {
            cartons.append(["product": "BOTTLES", "percentFull": Int(bottle)!])
        }
        if let soap = soapTextField.text, !soap.isEmpty {
            cartons.append(["product": "SOAP", "percentFull": Int(soap)!])
        }
        if let paper = paperTextField.text, !paper.isEmpty {
            cartons.append(["product": "PAPER", "percentFull": Int(paper)!])
        }
        if let other = otherTextField.text, !other.isEmpty {
            cartons.append(["product": "OTHER", "percentFull": Int(other)!])
        }
        if let linen = linenTextField.text, !linen.isEmpty {
            cartons.append(["product": "LINENS", "percentFull": Int(linen)!])
        }
        
        pickupController.schedule(collectionType: "LOCAL",
                                  status: "SUBMITTED",
                                  readyDate: dateStr,
                                  cartons: cartons,
                                  id: property.id!)
        
        navigationController?.popViewController(animated: true)
    }

}
