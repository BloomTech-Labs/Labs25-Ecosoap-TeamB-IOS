//
//  ImpactViewController.swift
//  labs-ios-starter
//
//  Created by Lydia Zhang on 8/12/20.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import UIKit

class ImpactViewController: UIViewController {
    
    let impactController = ImpactStatsController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - UI Properties
    
    @IBOutlet var soapLabel: UILabel!
    @IBOutlet var LinesnsLabel: UILabel!
    @IBOutlet var bottlesLabel: UILabel!
    @IBOutlet var paperLabel: UILabel!
    @IBOutlet var peopleLabel: UILabel!
    @IBOutlet var womenLabel: UILabel!
    
    func updateView() {
        impactController.fetchImpact() { impact in
            let result = try! impact.get()
            print("\(result)")
            DispatchQueue.main.async {
                self.soapLabel.text = "\(result.soapRecycled)"
                self.LinesnsLabel.text = "\(result.linensRecycled)"
                self.bottlesLabel.text = "\(result.bottlesRecycled)"
                self.paperLabel.text = "\(result.paperRecycled)"
                self.peopleLabel.text = "\(result.peopleServed)"
                self.womenLabel.text = "\(result.womenEmployed)"
            }
        }
    }

}
