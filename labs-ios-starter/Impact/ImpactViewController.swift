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
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateView()
    }
    // MARK: - UI Properties
    
    @IBOutlet var soapLabel: UILabel!
    @IBOutlet var LinesnsLabel: UILabel!
    @IBOutlet var bottlesLabel: UILabel!
    @IBOutlet var paperLabel: UILabel!
    @IBOutlet var peopleLabel: UILabel!
    @IBOutlet var womenLabel: UILabel!
    
    func updateView() {
        impactController.fetchImpact(id: "PropertyId1") { impact in
            let result = try! impact.get()
            print("\(result)")
            DispatchQueue.main.async {
                self.soapLabel.text = "\(result.soapRecycled ?? 0)"
                self.LinesnsLabel.text = "\(result.linensRecycled ?? 0)"
                self.bottlesLabel.text = "\(result.bottlesRecycled ?? 0)"
                self.paperLabel.text = "\(result.paperRecycled ?? 0)"
                self.peopleLabel.text = "\(result.peopleServed ?? 0)"
                self.womenLabel.text = "\(result.womenEmployed ?? 0)"
            }
        }
    }

}
