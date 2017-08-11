//
//  TermsAndConditionsVC.swift
//  UIStripeCustomPayoutFlow
//
//  Created by James Kauten on 8/10/17.
//  Copyright © 2017 Christian Kauten. All rights reserved.
//

import UIKit

/// a protocol for interracting with events from the terms and conditions view
protocol TermsAndConditionsVCDelegate {
    
    /// Respond to a the terms and conditions being accepted
    func didAcceptTermsAndConditions(_ on: TermsAndConditionsVC)
    
}

/// the terms and conditions page for the flow
class TermsAndConditionsVC: UIViewController {
    
    /// the delegate to pass events to if any
    var delegate: TermsAndConditionsVCDelegate?
    
    /// the text view to display the terms and conditions
    @IBOutlet weak var termsAndConditionsTextView: UITextView! {
        didSet {
            termsAndConditionsTextView.text = UIStripeCustomPayoutSetup.termsAndConditions
        }
    }

    /// the switch for users to use to agree
    @IBOutlet weak var agreementSwitch: UISwitch! {
        didSet {
            agreementSwitch.onTintColor = UIStripeCustomPayoutSetup.tintColor
        }
    }
    
    /// Respond to a press on the continue button
    @IBAction func didPressContinue() {
        guard agreementSwitch.isOn else {
            return
        }
        delegate?.didAcceptTermsAndConditions(self)
    }
    
    /// the continue button
    @IBOutlet weak var continueButton: ZFRippleButton! {
        didSet {
            continueButton.backgroundColor = UIStripeCustomPayoutSetup.buttonBackgroundColor
            continueButton.tintColor = UIStripeCustomPayoutSetup.tintColor
        }
    }
    
    /// Show a new instance of this view controller on top of the exisitng view
    /// controller
    /// - parameters:
    ///   - vc: the view controller to show on top of
    static func show(on vc: UIViewController) -> TermsAndConditionsVC {
        let name = String(describing: classForCoder())
        let bundle = Bundle(for: classForCoder())
        let storyboard = UIStoryboard(name: name, bundle: bundle)
        let welcomeVC = storyboard.instantiateInitialViewController() as! TermsAndConditionsVC
        vc.show(welcomeVC, sender: nil)
        return welcomeVC
    }
    
}
