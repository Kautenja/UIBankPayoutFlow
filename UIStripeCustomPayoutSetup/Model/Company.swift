//
//  Company.swift
//  UIStripeCustomPayoutFlow
//
//  Created by James Kauten on 8/10/17.
//  Copyright © 2017 Christian Kauten. All rights reserved.
//

import Foundation

/// the types of companies
public enum CompanyType: String {
    
    /// a company that embodies a single individual
    case individual = "individual"
    
    /// a company that embodies... well a company...
    case company = "company"
    
}

/// this struct contains fields to build a company object capable of providing
/// all the necessary information to process payments for a company using Stripe
public struct Company {
    
    /// the type of company this is
    public var type: CompanyType?
    
    /// the name of the company
    public var name: String?
    
    /// the location of the company
    public var address: Address?
    
    /// the company representative
    public var representative: Representative?
    
    /// the bank account payout information
    public var payout: BankAccount?
    
}
