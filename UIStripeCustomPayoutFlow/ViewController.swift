//
//  ViewController.swift
//  UIBankPayoutFlow
//
//  Created by James Kauten on 8/10/17.
//  Copyright © 2017 Christian Kauten. All rights reserved.
//

import UIKit
import UIBankPayoutFlow

/// the main view controller for the example
class ViewController: UIViewController {
    
    /// the text view to output to
    @IBOutlet weak var textView: UITextView!
    
    /// Respond to a press to the start button
    @IBAction func didPressStart() {
        /// show the setup flow on self with the given callback handler
        UIBankPayoutFlow.appName = "Very Good App"
        var terms = "Very reasonable terms and conditions. "
        for _ in 0...12 {
            terms += terms
        }
        UIBankPayoutFlow.termsAndConditions = terms
        UIBankPayoutFlow.tintColor = .orange
        UIBankPayoutFlow.logo = #imageLiteral(resourceName: "logo")
        UIBankPayoutFlow.show(on: self) { (company) in
            self.textView.text = "\(company)"
        }
    }
    
}

