//
//  MaterialSelectionCard.swift
//  Pods
//
//  Created by James Kauten on 6/29/17.
//
//

import UIKit
import UIXibView

/// This class models a Material design card with a static title and a dynamic
/// value that changes with selection.
@IBDesignable class MaterialSelectionCard: UIXibView {
    
    /// the card that the controls sit on top of
    @IBOutlet var card: MaterialCard!
    
    /// the background color of the card
    @IBInspectable var cardBackgroundColor: UIColor? {
        get {
            return card.backgroundColor
        }
        set {
            card.backgroundColor = newValue
        }
    }
    
    /// the radius for the corners of the card
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return card.cornerRadius
        }
        set {
            card.cornerRadius = newValue
        }
    }
    
    /// the constraint padding the image from the left side of the cell
    @IBOutlet weak var leftPadding: NSLayoutConstraint!
    
    /// the imageview on the left side of the view
    @IBOutlet weak private var imageView: UIImageView!
    
    /// the image to display on the image view
    @IBInspectable var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            resizeImage()
        }
    }
    
    /// Resize the auto layout based on the nullity of the image
    private func resizeImage() {
        if let _ = image {
            leftPadding.constant = 10
        } else {
            let imageViewWidth = imageView?.bounds.width ?? 0
            leftPadding.constant = -(imageViewWidth - 10)
        }
    }
    
    /// The tint color for the image (mainly for templates)
    @IBInspectable var imageTint: UIColor! {
        get {
            return imageView.tintColor
        }
        set {
            imageView.tintColor = newValue
        }
    }
    
    /// Whether the image is a template or not
    @IBInspectable var imageIsTemplate: Bool = false {
        didSet {
            if imageIsTemplate {
                image = image?.withRenderingMode(.alwaysTemplate)
            } else {
                image = image?.withRenderingMode(.alwaysOriginal)
            }
        }
    }
    
    /// Layout the subviews within the view
    override func layoutSubviews() {
        super.layoutSubviews()
        resizeImage()
    }
    
    /// the title of the card
    @IBOutlet var titleLabel: UILabel!
    
    /// the title for the card
    @IBInspectable var title: String? {
        set {
            titleLabel.text = newValue
        }
        get {
            return titleLabel.text
        }
    }
    
    /// the color of the text
    @IBInspectable var titleTextColor: UIColor? {
        set {
            titleLabel.textColor = newValue
        }
        get {
            return titleLabel.textColor
        }
    }
    
    /// the value of the selected item, defaults to "-"
    @IBOutlet var valueLabel: UILabel!
    
    /// the value for the card
    @IBInspectable var value: String? {
        set {
            valueLabel.text = newValue
        }
        get {
            return valueLabel.text
        }
    }
    
    /// the color of the text
    @IBInspectable var valueTextColor: UIColor? {
        set {
            valueLabel.textColor = newValue
        }
        get {
            return valueLabel.textColor
        }
    }
    
    /// the delegate for the selection card
    var delegate: MaterialCardDelegate? {
        get {
            return card.delegate
        }
        set {
            card.delegate = newValue
        }
    }
    
    /// Set the tap handler to a new escaping closure
    /// - parameters:
    ///   - block: the block to call when a tap occurs
    func setTapHandler(block: @escaping (MaterialCard) -> Void) {
        card.setTapHandler(block: block)
    }
    
    /// Handle a tap to the button on top of the card
    @IBAction func didTap() {
        card.consumeTap()
    }
    
}
