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

/// a protocol for interacting with events from a Material Room Picker Card
protocol MaterialRoomPickerCardDelegate {
    
    /// Respond to the address value changing to a prevalidated address
    /// - parameters:
    ///   - picker: the picker the event happened on
    ///   - address: the new address
    func addressDidChange(_ picker: MaterialRoomPickerCard, address: String?)
    
    /// Respond to the building name value changing
    /// - parameters:
    ///   - picker: the picker the event happened on
    ///   - building: the new building name
    func buildingDidChange(_ picker: MaterialRoomPickerCard, building: String?)
    
    /// Respond to the room number value changing
    /// - parameters:
    ///   - picker: the picker the event happened on
    ///   - room: the new room number
    func roomDidChange(_ picker: MaterialRoomPickerCard, room: String?)
    
}

/// this class gathers information about a room in a building while displaying
/// the building on a map
@IBDesignable class MaterialRoomPickerCard: UIXibView {
    
    /// the delegate to pass events along to
    var delegate: MaterialRoomPickerCardDelegate?
    
    /// the card that the controls sit on top of
    @IBOutlet var card: MaterialCard!
    
    /// the background color of the card
    @IBInspectable public var cardBackgroundColor: UIColor? {
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
                self.zoomMap(to: address.text!)
            }
        }
    }
    
    /// the text field with the building name info
    @IBOutlet weak var building: MaterialTextField! {
        didSet {
            building.field.delegate = self
            building.setFieldEditingChangedHandler { (building) in
                self.delegate?.buildingDidChange(self, building: building.text)
            }
        }
    }
    
    /// the text field with the room number info
    @IBOutlet weak var room: MaterialTextField! {
        didSet {
            room.field.delegate = self
            room.setFieldEditingChangedHandler { (room) in
                self.delegate?.roomDidChange(self, room: room.text)
            }
        }
    }
    
}



// MARK: UITextField delegate functions
extension MaterialRoomPickerCard: UITextFieldDelegate {
    
    /// switch keyboard focus as appropriate
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == address.field {
            _ = building.becomeFirstResponder()
        }
        else if textField == building.field {
            _ = room.becomeFirstResponder()
        }
        else {
            textField.resignFirstResponder()
        }
        return false
    }
}
