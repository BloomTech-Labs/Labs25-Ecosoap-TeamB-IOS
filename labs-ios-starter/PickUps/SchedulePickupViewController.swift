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
    
    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    } ()
    var cartons: [Any] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func schedulePressed(_ sender: Any) {
        let date = datePicker.date
        let dateStr = dateFormatter.string(from: date)
        if let bottle = bottleTextField.text, !bottle.isEmpty {
            cartons.append(["product":"BOTTLES","percentFull":"\(bottle)"])
        }
        if let soap = soapTextField.text, !soap.isEmpty {
            cartons.append(["product":"SOAP","percentFull":"\(soap)"])
        }
        if let paper = paperTextField.text, !paper.isEmpty {
            cartons.append(["product":"PAPER","percentFull":"\(paper)"])
        }
        if let other = otherTextField.text, !other.isEmpty {
            cartons.append(["product":"OTHER","percentFull":"\(other)"])
        }
        if let linen = linenTextField.text, !linen.isEmpty {
            cartons.append(["product":"LINENS","percentFull":"\(linen)"])
        }
        
        dismiss(animated: true, completion: nil)
    }

}
