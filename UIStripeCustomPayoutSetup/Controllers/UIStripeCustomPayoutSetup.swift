//
//  UIStripeCustomPayoutSetup.swift
//  UIStripeCustomPayoutFlow
//
//  Created by James Kauten on 8/10/17.
//  Copyright © 2017 Christian Kauten. All rights reserved.
//

import UIKit

/// the central entry point for the flow
public class UIStripeCustomPayoutSetup {
    
    /// the tint color for the view controllers
    public static var tintColor: UIColor = UIColor.yellow
    
    /// the logo for the app if any
    public static var logo: UIImage?
    
    /// the name of the company
    public static var companyName: String?
    
    /// the terms and conditions as a string
    public static var termsAndConditions: String?
    
    public static func show(on vc: UIViewController,
                            callback: @escaping (Company) -> Void) {
        let welcome = WelcomeVC.show(on: vc)
        let delegate = UIStripeCustomPayoutSetup()
        welcome.delegate = delegate
    }
    
}



// MARK: Welcome Screen Delegate Functions
extension UIStripeCustomPayoutSetup: WelcomeVCDelegate {
    
    /// Respond to a press on the get started button
    func didPressGetStarted() {
        NSLog("did press get started on Welcome screen")
    }

}
