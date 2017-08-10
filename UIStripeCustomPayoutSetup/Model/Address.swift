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
struct Address {
    
    /// the first line of the street address
    var street: String?
    
    /// the city the address is in
    var city: String?
    
    /// the state the city is in
    var state: String?
    
    /// the US postal code
    var zip: String?
    
}
