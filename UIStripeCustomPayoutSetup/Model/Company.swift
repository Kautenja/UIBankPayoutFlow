//
//  Company.swift
//  UIStripeCustomPayoutFlow
//
//  Created by James Kauten on 8/10/17.
//  Copyright © 2017 Christian Kauten. All rights reserved.
//

import Foundation

/// the types of companies
enum CompanyType: String {
    
    /// a company that embodies a single individual
    case individual = "individual"
    
    /// a company that embodies... well a company...
    case company = "company"
    
}

/// this struct contains fields to build a company object capable of providing
/// all the necessary information to process payments for a company using Stripe
struct Company {
    
    /// the type of company this is
    var type: CompanyType?
    
    /// the name of the company
    var name: String?
    
    /// the location of the company
    var address: Address?
    
    /// the company representative
    var representative: Representative?
    
    /// the bank account payout information
    var payout: BankAccount?
    
}
