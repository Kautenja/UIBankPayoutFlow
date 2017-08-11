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
class PayoutInformationVC: UIViewController {
    
    /// the delegate to pass events to if any
    var delegate: PayoutInformationVCDelegate?
    
    /// the bank account information to fill in the form
    var bankAccount = BankAccount()
    
    /// the text field for collecting the routing number
    @IBOutlet weak var routingNumber: MaterialTextField! {
        didSet {
            routingNumber.field.tintColor = UIStripeCustomPayoutSetup.tintColor
            routingNumber.field.delegate = self
            routingNumber.setFieldEditingChangedHandler { (field) in
                guard field.text!.characters.count <= 9 else {
                    let index = field.text!.index(field.text!.startIndex, offsetBy: 9)
                    field.text = field.text!.substring(to: index)
                    return
                }
                self.bankAccount.routingNumber = field.text
            }
        }
    }
    
    /// the text field for collecting the account number
    @IBOutlet weak var accountNumber: MaterialTextField! {
        didSet {
            accountNumber.field.tintColor = UIStripeCustomPayoutSetup.tintColor
            accountNumber.field.delegate = self
            accountNumber.setFieldEditingChangedHandler { (field) in
                self.bankAccount.accountNumber = field.text
            }
        }
    }
    
    /// Respond to a press on the continue button
    @IBAction func didPressContinue() {
        guard let routingNumber = bankAccount.routingNumber, routingNumber.characters.count == 9 else {
            PopupAlert.show(on: self,
                            title: "What's your routing number?",
                            message: "you must provide the 9 digit routing number for your bank")
            return
        }
        guard let _ = bankAccount.accountNumber else {
            PopupAlert.show(on: self,
                            title: "What's your bank account number?",
                            message: "you must provide the account number for your bank")
            return
        }
        delegate?.didFill(self, account: bankAccount)
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
    static func show(on vc: UIViewController) -> PayoutInformationVC {
        let name = String(describing: classForCoder())
        let bundle = Bundle(for: classForCoder())
        let storyboard = UIStoryboard(name: name, bundle: bundle)
        let welcomeVC = storyboard.instantiateInitialViewController() as! PayoutInformationVC
        vc.show(welcomeVC, sender: nil)
        return welcomeVC
    }
    
    /// Setup the view on load
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        view.addGestureRecognizer(tap)
    }
    
    /// Respond to a tap on the tableview
    func didTapView() {
        view.endEditing(true)
    }
    
}



// MARK: Text Field Functions
extension PayoutInformationVC: UITextFieldDelegate {
    
    /// Handle a press to the return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case routingNumber.field:
            _ = accountNumber.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return false
    }
    
}
