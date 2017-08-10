//
//  DoneVC.swift
//  UIStripeCustomPayoutFlow
//
//  Created by James Kauten on 8/10/17.
//  Copyright © 2017 Christian Kauten. All rights reserved.
//

import UIKit

/// a protocol for interracting with events from the done view
protocol DoneVCDelegate {
    
    /// Respond to a press on the get started button
    func didPressDone(_ on: DoneVC)
    
}

/// the welcome page for the flow
public class DoneVC: UIViewController {
    
    /// the delegate to pass events to if any
    var delegate: DoneVCDelegate?
    
    /// the company logo to display
    @IBOutlet weak var logo: UIImageView! {
        didSet {
            logo.image = UIStripeCustomPayoutSetup.logo
        }
    }
    
    /// The label with the all setup message, try to add an app name disclosure
    /// if there is one, else just leave as is
    @IBOutlet weak var allSetUpLabel: UITextView! {
        didSet {
            guard let appName = UIStripeCustomPayoutSetup.appName else {
                return
            }
            allSetUpLabel.text = allSetUpLabel.text + " with \(appName)"
        }
    }
    /// Respond to a press on the get started button
    @IBAction func didPressGetStarted() {
        delegate?.didPressDone(self)
    }
    
    /// Show a new instance of this view controller on top of the exisitng view 
    /// controller
    /// - parameters:
    ///   - vc: the view controller to show on top of
    public static func show(on vc: UIViewController) -> DoneVC {
        let name = String(describing: classForCoder())
        let bundle = Bundle(for: classForCoder())
        let storyboard = UIStoryboard(name: name, bundle: bundle)
        let welcomeVC = storyboard.instantiateInitialViewController() as! DoneVC
        vc.show(welcomeVC, sender: nil)
        return welcomeVC
    }
    
}
