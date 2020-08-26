//
//  SchedulePickupViewController.swift
//  labs-ios-starter
//
//  Created by Lydia Zhang on 8/25/20.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import UIKit



class SchedulePickupViewController: UIViewController {
    
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var bottleTextField: UITextField!
    @IBOutlet var linenTextField: UITextField!
    @IBOutlet var otherTextField: UITextField!
    @IBOutlet var soapTextField: UITextField!
    @IBOutlet var paperTextField: UITextField!
    
    var pickupController: PickupController?
    var property: Property?
    
    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    } ()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func schedulePressed(_ sender: Any) {
        
        guard let pickupController = pickupController, let property = property else {return}
        var cartons: [String:Any] = [:]
        
        let date = datePicker.date
        let dateStr = dateFormatter.string(from: date)
        
        if let bottle = bottleTextField.text, !bottle.isEmpty {
            cartons["product"] = "BOTTLES"
            cartons["percentFull"] = Int(bottle)
        }
        if let soap = soapTextField.text, !soap.isEmpty {
            cartons["product"] = "SOAP"
            cartons["percentFull"] = Int(soap)
        }
        if let paper = paperTextField.text, !paper.isEmpty {
            cartons["product"] = "PAPER"
            cartons["percentFull"] = Int(paper)
        }
        if let other = otherTextField.text, !other.isEmpty {
            cartons["product"] = "OTHER"
            cartons["percentFull"] = Int(other)
        }
        if let linen = linenTextField.text, !linen.isEmpty {
            cartons["product"] = "LINENS"
            cartons["percentFull"] = Int(linen)
        }
        
        print(cartons)
        pickupController.schedule(collectionType: "LOCAL", status: "SUBMITTED", readyDate: dateStr, cartons: cartons, id: property.id!)
        navigationController?.popViewController(animated: true)
    }

}
