//
//  MaterialAddressCard.swift
//  UIStripeCustomPayoutFlow
//
//  Created by James Kauten on 8/10/17.
//  Copyright © 2017 Christian Kauten. All rights reserved.
//

import UIKit
import UIXibView
import MapKit
import CoreLocation

/// a list of state abbreviations
let states = ["AL","AK","AZ","AR","CA","CO","CT","DE","DC","FL","GA","HI","ID","IL",
              "IN","IA","KS","KY","LA","ME","MT","NE","NV","NH","NJ","NM","NY","NC",
              "ND","OH","OK","OR","MD","MA","MI","MN","MS","MO","PA","RI","SC","SD",
              "TN","TX","UT","VT","VA","WA","WV","WI","WY"]

/// a protocol for interacting with events from a Material Room Picker Card
protocol MaterialAddressCardDelegate {
    
    /// Respond to the address value changing to a prevalidated address
    /// - parameters:
    ///   - picker: the picker the event happened on
    ///   - address: the new address
    func addressDidChange(_ picker: MaterialAddressCard, address: String?)
    
    /// Respond to the address value changing to a prevalidated address
    /// - parameters:
    ///   - picker: the picker the event happened on
    ///   - city: the new city
    func cityDidChange(_ picker: MaterialAddressCard, city: String?)
    
    /// Respond to the address value changing to a prevalidated address
    /// - parameters:
    ///   - picker: the picker the event happened on
    ///   - state: the new state
    func stateDidChange(_ picker: MaterialAddressCard, state: String?)
    
    /// Respond to the address value changing to a prevalidated address
    /// - parameters:
    ///   - picker: the picker the event happened on
    ///   - zip: the new zip
    func zipDidChange(_ picker: MaterialAddressCard, zip: String?)
    
}

/// this class gathers information about an address and displays it on a map
@IBDesignable class MaterialAddressCard: UIXibView {
    
    /// the delegate to pass events along to
    var delegate: MaterialAddressCardDelegate?
    
    /// the card that the controls sit on top of
    @IBOutlet var card: MaterialCard!
    
    /// the background color of the card
    @IBInspectable
    var cardBackgroundColor: UIColor? {
        get {
            return card.backgroundColor
        }
        set {
            card.backgroundColor = newValue
        }
    }
    
    /// the radius for the corners of the card
    @IBInspectable public var cornerRadius: CGFloat {
        get {
            return card.cornerRadius
        }
        set {
            card.cornerRadius = newValue
        }
    }
    
    /// the geocoder for lookin up coordinates by address
    var geocoder: CLGeocoder!
    
    /// the default zoom window for points on the map
    var span: MKCoordinateSpan!
    
    /// the map view
    @IBOutlet weak var map: MKMapView! {
        didSet {
            geocoder = CLGeocoder()
            span = MKCoordinateSpanMake(0.001, 0.001)
        }
    }
    
    /// Zoom the map view to the address in the given string
    /// - parameters:
    ///   - addr: the address to zoom the map to
    func zoomMap(to addr: String) {
        geocoder.geocodeAddressString(addr) { (placemarks, error) in
            if let error = error {
                NSLog(error.localizedDescription)
                return
            }
            guard let placemark = placemarks?[0] else {
                NSLog("no placemarks")
                return
            }
            guard let location = placemark.location else {
                NSLog("no coordinates for placemark")
                return
            }
            let region = MKCoordinateRegionMake(location.coordinate, self.span)
            self.map.setRegion(region, animated: true)
        }
    }
    
    /// the text field with the address info
    @IBOutlet weak var address: MaterialTextField! {
        didSet {
            address.field.delegate = self
            address.setFieldEditingChangedHandler { (address) in
                self.delegate?.addressDidChange(self, address: address.text)
                self.zoomMap(to: self.completeAddress!)
            }
        }
    }
    
    /// the text field with the city info
    @IBOutlet weak var city: MaterialTextField! {
        didSet {
            city.field.delegate = self
            city.setFieldEditingChangedHandler { (city) in
                self.delegate?.cityDidChange(self, city: city.text)
                self.zoomMap(to: self.completeAddress!)
            }
        }
    }
    
    /// the picker view containing the selected state
    @IBOutlet weak var state: UIPickerView!
    
    /// the text field with the zip info
    @IBOutlet weak var zip: MaterialTextField! {
        didSet {
            zip.field.delegate = self
            zip.setFieldEditingChangedHandler { (zip) in
                self.delegate?.zipDidChange(self, zip: zip.text)
                self.zoomMap(to: self.completeAddress!)
            }
        }
    }
    
    /// Return a string with the complete formatted address
    var completeAddress: String! {
        let _state = states[state.selectedRow(inComponent: 0)]
        return "\(address.text!), \(city.text!), \(_state) \(zip.text!)"
    }
    
}



// MARK: UITextField delegate functions
extension MaterialAddressCard: UITextFieldDelegate {
    
    /// switch keyboard focus as appropriate
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == address.field {
            _ = city.becomeFirstResponder()
        }
        else if textField == city.field {
            _ = zip.becomeFirstResponder()
        }
        else {
            textField.resignFirstResponder()
        }
        return false
    }
    
}



// MARK: Picker view delegate functions
extension MaterialAddressCard: UIPickerViewDataSource, UIPickerViewDelegate {

    /// Return the number of states in the picker
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return states.count
    }

    /// only one component, the state
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    /// return the name of the state for the row
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return states[row]
    }
    
    /// Respond to a row (state) being selected
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        delegate?.stateDidChange(self, state: states[row])
        zoomMap(to: self.completeAddress!)
    }
    
}
