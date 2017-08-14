//
//  WelcomeVC.swift
//  UIBankPayoutFlow
//
//  Created by James Kauten on 8/10/17.
//  Copyright © 2017 Christian Kauten. All rights reserved.
//

import UIKit

/// a protocol for interracting with events from the welcome view
protocol WelcomeVCDelegate {
    
    /// Respond to a press on the get started button
    func didPressGetStarted(_ on: WelcomeVC)
    
}

/// the welcome page for the flow
class WelcomeVC: UIViewController {
    
    /// the delegate to pass events to if any
    var delegate: WelcomeVCDelegate?
    
    /// the company logo to display
    @IBOutlet weak var logo: UIImageView! {
        didSet {
            logo.image = UIBankPayoutFlow.logo
        }
    }

    /// the name of the app
    @IBOutlet weak var appNameLabel: UILabel! {
        didSet {
            guard let appName = UIBankPayoutFlow.appName else {
                return
            }
            appNameLabel.text = "\(appName)!"
        }
    }
    
    /// Respond to a press on the get started button
    @IBAction func didPressGetStarted() {
        delegate?.didPressGetStarted(self)
    }
    
    /// the get started button
    @IBOutlet weak var getStarted: ZFRippleButton! {
        didSet {
            getStarted.backgroundColor = UIBankPayoutFlow.buttonBackgroundColor
            getStarted.tintColor = UIBankPayoutFlow.tintColor
        }
    }
    
    /// Show a new instance of this view controller on top of the exisitng view
    /// controller
    /// - parameters:
    ///   - vc: the view controller to show on top of
    static func show(on vc: UIViewController) -> WelcomeVC {
        let name = String(describing: classForCoder())
        let bundle = Bundle(for: classForCoder())
        let storyboard = UIStoryboard(name: name, bundle: bundle)
        let welcomeVC = storyboard.instantiateInitialViewController() as! WelcomeVC
        vc.show(welcomeVC, sender: nil)
        return welcomeVC
    }
    
}
