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
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateView()
    }
    // MARK: - UI Properties
    
    @IBOutlet private var propertyIDLabel: UILabel!
    @IBOutlet private var soapLabel: UILabel!
    @IBOutlet private var LinesnsLabel: UILabel!
    @IBOutlet private var bottlesLabel: UILabel!
    @IBOutlet private var paperLabel: UILabel!
    @IBOutlet private var peopleLabel: UILabel!
    @IBOutlet private var womenLabel: UILabel!
    
    func updateView() {
        
        guard let propertyID = defaults.string(forKey: "PropertyId") else { return }
        
        impactController.fetchImpact(id: propertyID) { impact in
            do {
                let result = try impact.get()
                
                DispatchQueue.main.async {
                    self.propertyIDLabel.text = "\(propertyID)"
                    self.soapLabel.text = "\(result.soapRecycled ?? 0)"
                    self.LinesnsLabel.text = "\(result.linensRecycled ?? 0)"
                    self.bottlesLabel.text = "\(result.bottlesRecycled ?? 0)"
                    self.paperLabel.text = "\(result.paperRecycled ?? 0)"
                    self.peopleLabel.text = "\(result.peopleServed ?? 0)"
                    self.womenLabel.text = "\(result.womenEmployed ?? 0)"
                }
            } catch {
                print("ImpactViewController.updateView() impact.get() failed.")
            }
        }
    }

}
