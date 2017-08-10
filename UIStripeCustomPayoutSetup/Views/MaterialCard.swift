//
//  MaterialCard.swift
//  UIStripeCustomPayoutFlow
//
//  Created by James Kauten on 8/10/17.
//  Copyright © 2017 Christian Kauten. All rights reserved.
//

import UIKit

/// a protocol for passing events/data between MaterialCards and other obejcts
/// - best used when delegating reusable cards (use setTapHandler for static
///   instances)
protocol MaterialCardDelegate {
    
    /// Handle a tap to a card
    /// - parameters:
    ///   - card: the card that was selected
    func didTap(_ card: MaterialCard)
    
}

/// This class models a Material design card with a background shadow
@IBDesignable class MaterialCard: UIView {
    
    /// the delegate to send events to
    public var delegate: MaterialCardDelegate?
    
    /// the radius for the corners of the card
    @IBInspectable public var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = false
            layer.shadowColor = UIColor.lightGray.cgColor
            layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
            layer.shadowOpacity = 0.5
        }
    }
    
    /// Initialize with the given frame
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    /// Initialzie with the given decoder
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    /// Perform global initialization between init functions
    private func setup() {
        clipsToBounds = true
        layer.cornerRadius = 4
        layer.masksToBounds = false
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        layer.shadowOpacity = 0.5
    }
    
    /// setup the views after loading from nib
    override open func awakeFromNib() {
        super.awakeFromNib()
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(consumeTap))
        addGestureRecognizer(tap)
    }
    
    /// Consume a tap to the card
    @objc func consumeTap() {
        delegate?.didTap(self)
        tapHandler?(self)
    }
    
    /// the function to call when consuming tap events
    private var tapHandler: ((MaterialCard) -> Void)?
    
    /// Set the tap handler to a new escaping closure
    /// - parameters:
    ///   - block: the block to call when a tap occurs
    public func setTapHandler(block: @escaping (MaterialCard) -> Void) {
        tapHandler = block
    }
    
}
