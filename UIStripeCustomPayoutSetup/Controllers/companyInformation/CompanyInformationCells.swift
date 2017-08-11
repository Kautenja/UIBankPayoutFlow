//
//  CompanyInformationCells.swift
//  UIStripeCustomPayoutFlow
//
//  Created by James Kauten on 8/10/17.
//  Copyright © 2017 Christian Kauten. All rights reserved.
//

import UIKit

class NameCell: UITableViewCell {
    
    @IBOutlet weak var field: MaterialTextField!
    
}

class TypeCell: UITableViewCell {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
}

class AddressCell: UITableViewCell {
    
    @IBOutlet weak var card: MaterialAddressCard!
    
}

class RepresentativeNameCell: UITableViewCell {
    
    @IBOutlet weak var first: MaterialTextField!
    
    @IBOutlet weak var middle: MaterialTextField!
    
    @IBOutlet weak var last: MaterialTextField!
    
}

class RepresentativeSSNCell: UITableViewCell {
    
    @IBOutlet weak var field: MaterialTextField!
    
}

class RepresentativeDOBCell: UITableViewCell {
    
    @IBOutlet weak var picker: UIDatePicker!
    
}
