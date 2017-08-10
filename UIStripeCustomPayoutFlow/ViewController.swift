//
//  ViewController.swift
//  UIStripeCustomPayoutFlow
//
//  Created by James Kauten on 8/10/17.
//  Copyright © 2017 Christian Kauten. All rights reserved.
//

import UIKit
import UIStripeCustomPayoutSetup

/// the main view controller for the example
class ViewController: UIViewController {
    
    /// Update the view controller with data from the given company
    func updateOuput(_ company: Company) {
        
    }
    
    /// Respond to a press to the start button
    @IBAction func didPressStart() {
        /// show the setup flow on self with the given callback handler
        UIStripeCustomPayoutSetup.show(on: self) { (company) in
            self.updateOuput(company)
            NSLog("\(company)")
        }
    }
    
}

