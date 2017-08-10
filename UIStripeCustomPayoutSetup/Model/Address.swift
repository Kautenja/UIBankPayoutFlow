//
//  Address.swift
//  UIStripeCustomPayoutFlow
//
//  Created by James Kauten on 8/10/17.
//  Copyright © 2017 Christian Kauten. All rights reserved.
//

import Foundation

/// a physical address represented by its modular pieces according to US
/// requirements for addresses
public struct Address {
    
    /// the first line of the street address
    public var street: String?
    
    /// the city the address is in
    public var city: String?
    
    /// the state the city is in
    public var state: String?
    
    /// the US postal code
    public var zip: String?
    
}
