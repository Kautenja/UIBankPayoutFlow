//
//  WelcomeVC.swift
//  UIStripeCustomPayoutFlow
//
//  Created by James Kauten on 8/10/17.
//  Copyright © 2017 Christian Kauten. All rights reserved.
//

import UIKit

/// a protocol for interracting with events from the welcome view
protocol WelcomeVCDelegate {
    
    /// Respond to a press on the get started button
    func didPressGetStarted()
    
}

/// the welcome page for the flow
public class WelcomeVC: UIViewController {
    
    /// the delegate to pass events to if any
    var delegate: WelcomeVCDelegate?
    
    /// the company logo to display
    @IBOutlet weak var logo: UIImageView!
    
    /// the name of the company
    @IBOutlet weak var companyName: UILabel!
    
    /// Respond to a press on the get started button
    @IBAction func didPressGetStarted() {
        
    }
    
    public static func show(on vc: UIViewController) -> WelcomeVC {
        let name = String(describing: classForCoder())
        let bundle = Bundle(for: classForCoder())
        let storyboard = UIStoryboard(name: name, bundle: bundle)
        let welcomeVC = storyboard.instantiateInitialViewController() as! WelcomeVC
        // TODO: setup the view controller with deocrative code
        
        vc.show(welcomeVC, sender: nil)
        return welcomeVC
    }
    
}
