//
//  PopupAlert.swift
//  UIStripeCustomPayoutFlow
//
//  Created by James Kauten on 8/10/17.
//  Copyright © 2017 Christian Kauten. All rights reserved.
//

import PopupDialog

/// A class for easilly dsplaying alerts with static methods
class PopupAlert {
    
    /// Present an alert on top of an existing view controller with a title,
    /// message, and ack button
    /// - parameters:
    ///   - on: the view controller to present on
    ///   - title: the title of the alert
    ///   - message: the corresponding descriptive message of the alert
    class func show(on viewController: UIViewController,
                    title: String?=nil,
                    message: String?=nil) {
        let popup = PopupDialog(title: title, message: message)
        let acknowledge = DefaultButton(title: "Ok") { }
        acknowledge.titleColor = UIStripeCustomPayoutSetup.tintColor
        popup.addButton(acknowledge)
        viewController.present(popup, animated: true, completion: nil)
    }
    
}
