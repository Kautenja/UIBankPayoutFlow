//
//  PayoutInformationVC.swift
//  UIStripeCustomPayoutFlow
//
//  Created by James Kauten on 8/10/17.
//  Copyright © 2017 Christian Kauten. All rights reserved.
//

import UIKit

/// a protocol for interracting with events from the payout information view
protocol PayoutInformationVCDelegate {
    
    /// Respond to the form being filled
    func didFill(_ on: PayoutInformationVC, account: BankAccount)
    
}

/// the payout information page for the flow
public class PayoutInformationVC: UIViewController {
    
    /// the delegate to pass events to if any
    var delegate: PayoutInformationVCDelegate?
    
    /// Respond to a press on the continue button
    @IBAction func didPressContinue() {
        delegate?.didFill(self, account: BankAccount())
    }
    
    /// Show a new instance of this view controller on top of the exisitng view
    /// controller
    /// - parameters:
    ///   - vc: the view controller to show on top of
    public static func show(on vc: UIViewController) -> PayoutInformationVC {
        let name = String(describing: classForCoder())
        let bundle = Bundle(for: classForCoder())
        let storyboard = UIStoryboard(name: name, bundle: bundle)
        let welcomeVC = storyboard.instantiateInitialViewController() as! PayoutInformationVC
        vc.show(welcomeVC, sender: nil)
        return welcomeVC
    }
    
}
