//
//  TermsAndConditionsVC.swift
//  UIStripeCustomPayoutFlow
//
//  Created by James Kauten on 8/10/17.
//  Copyright © 2017 Christian Kauten. All rights reserved.
//

import UIKit

/// a protocol for interracting with events from the welcome view
protocol TermsAndConditionsVCDelegate {
    
    /// Respond to a press on the get started button
    func didAcceptTermsAndConditions(_ on: TermsAndConditionsVC)
    
}

/// the welcome page for the flow
public class TermsAndConditionsVC: UIViewController {
    
    /// the delegate to pass events to if any
    var delegate: TermsAndConditionsVCDelegate?
    
    /// the text view to display the terms and conditions
    @IBOutlet weak var termsAndConditionsTextView: UITextView!
    
    /// the switch for users to use to agree
    @IBOutlet weak var agreementSwitch: UISwitch!
    
    /// Respond to a press on the get started button
    @IBAction func didPressContinue() {
        guard agreementSwitch.isOn else {
            return
        }
        delegate?.didAcceptTermsAndConditions(self)
    }
    
    public static func show(on vc: UIViewController) -> TermsAndConditionsVC {
        let name = String(describing: classForCoder())
        let bundle = Bundle(for: classForCoder())
        let storyboard = UIStoryboard(name: name, bundle: bundle)
        let welcomeVC = storyboard.instantiateInitialViewController() as! TermsAndConditionsVC
        // TODO: setup the view controller with deocrative code
        
        vc.show(welcomeVC, sender: nil)
        return welcomeVC
    }
    
}
