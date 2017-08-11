//
//  UIStripeCustomPayoutSetup.swift
//  UIStripeCustomPayoutFlow
//
//  Created by James Kauten on 8/10/17.
//  Copyright © 2017 Christian Kauten. All rights reserved.
//

import UIKit

/// the central entry point for the flow
public class UIStripeCustomPayoutSetup: UINavigationController {
    
    /// the background color of the buttons
    public static var buttonBackgroundColor: UIColor = .white
    
    /// the tint color for the view controllers
    public static var tintColor: UIColor = .yellow
    
    /// the logo for the app if any
    public static var logo: UIImage?
    
    /// the name of the company
    public static var appName: String?
    
    /// the terms and conditions as a string
    public static var termsAndConditions: String?
    
    /// the company being mutated by the view controller
    var company: Company!
    
    /// the callback for the flow
    var callback: ((Company) -> Void)!
    
    /// Show the view controller on the existing view controller with a callback
    /// - parameters:
    ///   - vc: the view controller to present on top of
    ///   - callback: the callback function for when the setup completes
    public static func show(on vc: UIViewController,
                            callback: @escaping (Company) -> Void) {
        // create an instance of self
        let nc = UIStripeCustomPayoutSetup()
        nc.isNavigationBarHidden = true
        nc.callback = callback
        // create welcom screen on the navigation controller
        let welcome = WelcomeVC.show(on: nc)
        welcome.delegate = nc
        // present the navigation controller
        vc.present(nc, animated: true)
    }
    
}



// MARK: Welcome Screen Delegate Functions
extension UIStripeCustomPayoutSetup: WelcomeVCDelegate {
    
    /// Respond to a press on the get started button
    func didPressGetStarted(_ on: WelcomeVC) {
        NSLog("did press get started on welcome screen")
        let termsAndConditions = TermsAndConditionsVC.show(on: on)
        termsAndConditions.delegate = self
    }

}



// MARK: Terms And Conditions Screen Delegate Functions
extension UIStripeCustomPayoutSetup: TermsAndConditionsVCDelegate {
    
    /// Respond to a press on the continue button
    func didAcceptTermsAndConditions(_ on: TermsAndConditionsVC) {
        NSLog("did accept terms and conditions")
        let companyInformation = CompanyInformationVC.show(on: on)
        companyInformation.delegate = self
    }
    
}



// MARK: Company Information Screen Delegate Functions
extension UIStripeCustomPayoutSetup: CompanyInformationVCDelegate {
    
    /// Respond to the form being filled
    func didFill(_ on: CompanyInformationVC, company: Company) {
        NSLog("did fill company information form with company: \(company)")
        self.company = company
        let payoutInformation = PayoutInformationVC.show(on: on)
        payoutInformation.delegate = self
    }
    
}



// MARK: Payout Information Screen Delegate Functions
extension UIStripeCustomPayoutSetup: PayoutInformationVCDelegate {
    
    /// Respond to the form being filled
    func didFill(_ on: PayoutInformationVC, account: BankAccount) {
        NSLog("did fill payout information form with account: \(account)")
        company.payout = account
        let done = DoneVC.show(on: on)
        done.delegate = self
    }
    
}



// MARK: Payout Information Screen Delegate Functions
extension UIStripeCustomPayoutSetup: DoneVCDelegate {
    
    /// Respond to a press on the get started button button
    func didPressDone(_ on: DoneVC) {
        NSLog("did finish setup")
        dismiss(animated: true)
        callback(company)
    }
    
}
