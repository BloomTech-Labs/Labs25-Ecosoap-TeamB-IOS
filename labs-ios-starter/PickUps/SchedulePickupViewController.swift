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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func schedulePressed(_ sender: Any) {
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
