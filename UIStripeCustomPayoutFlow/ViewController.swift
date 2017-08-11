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
    
    /// the text view to output to
    @IBOutlet weak var textView: UITextView!
    
    /// Respond to a press to the start button
    @IBAction func didPressStart() {
        /// show the setup flow on self with the given callback handler
        UIStripeCustomPayoutSetup.appName = "Very Good App"
        var terms = "Very reasonable terms and conditions. "
        for _ in 0...12 {
            terms += terms
        }
        UIStripeCustomPayoutSetup.termsAndConditions = terms
        UIStripeCustomPayoutSetup.tintColor = .orange
        UIStripeCustomPayoutSetup.logo = #imageLiteral(resourceName: "logo")
        UIStripeCustomPayoutSetup.show(on: self) { (company) in
            self.textView.text = "\(company)"
        }
    }
    
}

