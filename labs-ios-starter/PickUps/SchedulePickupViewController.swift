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
        formatter.dateFormat = "MM dd, yyyy"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func schedulePressed(_ sender: Any) {
        let date = datePicker.date
        let dateStr = dateFormatter.string(from: date)
        
        dismiss(animated: true, completion: nil)
    }

}
