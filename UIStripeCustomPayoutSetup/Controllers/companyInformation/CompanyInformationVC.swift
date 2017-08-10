//
//  CompanyInformationVC.swift
//  UIStripeCustomPayoutFlow
//
//  Created by James Kauten on 8/10/17.
//  Copyright © 2017 Christian Kauten. All rights reserved.
//

import UIKit

/// a protocol for interracting with events from the company information view
protocol CompanyInformationVCDelegate {
    
    /// Respond to a press on the get started button
    func didFill(_ on: CompanyInformationVC, company: Company)
    
}

/// the company information page for the flow
public class CompanyInformationVC: UIViewController {
    
    /// the delegate to pass events to if any
    var delegate: CompanyInformationVCDelegate?
    
    /// Respond to a press on the continue button
    @IBAction func didPressContinue() {
        delegate?.didFill(self, company: Company())
    }
    
    public static func show(on vc: UIViewController) -> CompanyInformationVC {
        let name = String(describing: classForCoder())
        let bundle = Bundle(for: classForCoder())
        let storyboard = UIStoryboard(name: name, bundle: bundle)
        let welcomeVC = storyboard.instantiateInitialViewController() as! CompanyInformationVC
        vc.show(welcomeVC, sender: nil)
        return welcomeVC
    }
    
}
