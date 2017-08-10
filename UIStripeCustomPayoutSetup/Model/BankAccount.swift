//
//  BankAccount.swift
//  UIStripeCustomPayoutFlow
//
//  Created by James Kauten on 8/10/17.
//  Copyright © 2017 Christian Kauten. All rights reserved.
//

import Foundation

/// a US bank account with relevant data needed for payouts
public struct BankAccount {
    
    /// the routing number of the account
    public var routingNumber: String?
    
    /// the account number for the account
    public var accountNumber: String?
    
}
