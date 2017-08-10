//
//  BankAccount.swift
//  UIStripeCustomPayoutFlow
//
//  Created by James Kauten on 8/10/17.
//  Copyright © 2017 Christian Kauten. All rights reserved.
//

import Foundation

/// a US bank account with relevant data needed for payouts
struct BankAccount {
    
    /// the routing number of the account
    var routingNumber: String?
    
    /// the account number for the account
    var accountNumber: String?
    
}
