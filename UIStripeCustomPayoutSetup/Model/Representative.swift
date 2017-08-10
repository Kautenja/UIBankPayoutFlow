//
//  Representative.swift
//  UIStripeCustomPayoutFlow
//
//  Created by James Kauten on 8/10/17.
//  Copyright © 2017 Christian Kauten. All rights reserved.
//

import Foundation

/// a representative for the company, this includes all relevant metadata as 
/// needed for payments processing according to basic US standards
public struct Representative {
    
    /// the first name of the person
    public var firstName: String?
    
    /// the middle name of the person
    public var middleName: String?
    
    /// the last/family name of the persone
    public var lastName: String?
    
    /// the date of birth of the person
    public var dob: Date?
    
    /// the person's US social security number
    public var ssn: String?
    
}
