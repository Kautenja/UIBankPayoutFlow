//
//  MaterialTextField.swift
//  UIStripeCustomPayoutFlow
//
//  Created by James Kauten on 8/10/17.
//  Copyright © 2017 Christian Kauten. All rights reserved.
//

import UIXibView

/// This class models a Material design card with a background shadow
@IBDesignable class MaterialTextField: UIXibView {
    
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
    
    /// the text field to enter data into
    @IBOutlet public var field: UITextField! {
        didSet {
            field.delegate = self
            field.addTarget(self, action: #selector(fieldDidChange), for: .editingChanged)
        }
    }
    
    /// the function to call when the field changes (setup by the escaping set
    /// up call)
    private var fieldChangeHandler: ((MaterialTextField) -> Void)?
    
    /// Handle a change in the field
    func fieldDidChange() {
        fieldChangeHandler?(self)
    }
    
    /// Set the field change handler to something new (this is designed to be
    /// called in a didSet handler to keep code related to textfields local
    /// via the escaping callback function)
    public func setFieldEditingChangedHandler(block: @escaping (MaterialTextField) -> Void) {
        fieldChangeHandler = block
    }
    
    /// the text on the field
    @IBInspectable public var text: String? {
        set {
            field.text = newValue
        }
        get {
            return field.text
        }
    }
    
    /// the color of the text
    @IBInspectable public var textColor: UIColor? {
        set {
            field.textColor = newValue
        }
        get {
            return field.textColor
        }
    }
    
    /// the text to display when the field is empty
    @IBInspectable public var minimumFontSize: CGFloat {
        get {
            return field.minimumFontSize
        }
        set {
            field.minimumFontSize = newValue
        }
    }
    
    /// the text to display when the field is empty
    @IBInspectable public var placeholder: String? {
        get {
            return field.placeholder
        }
        set {
            field.placeholder = newValue
        }
    }
    
    /// whether to clear the text when editing begins or not
    @IBInspectable public var clearWhenEditingBegins: Bool {
        get {
            return field.clearsOnBeginEditing
        }
        set {
            field.clearsOnBeginEditing = newValue
        }
    }
    
    /// whether the text field is secure or not
    @IBInspectable public var secureTextEntry: Bool {
        get {
            return field.isSecureTextEntry
        }
        set {
            field.isSecureTextEntry = newValue
        }
    }
    
    /// whether to use autocorrect
    @IBInspectable public var correction: Bool {
        get {
            return field.autocorrectionType == .yes
        }
        set {
            if newValue {
                field.autocorrectionType = .yes
            } else {
                field.autocorrectionType = .no
            }
        }
    }
    
    // these are iOS 10 only
    //    /// whether to use smart dashes
    //    @IBInspectable var smartDashes: Bool {
    //        get {
    //            return field.smartDashesType == .yes
    //        }
    //        set {
    //            if newValue {
    //                field.smartDashesType = .yes
    //            } else {
    //                field.smartDashesType = .no
    //            }
    //        }
    //    }
    //
    //    /// whether to use smart insert
    //    @IBInspectable var smartInsert: Bool {
    //        get {
    //            return field.smartInsertDeleteType == .yes
    //        }
    //        set {
    //            if newValue {
    //                field.smartInsertDeleteType = .yes
    //            } else {
    //                field.smartInsertDeleteType = .no
    //            }
    //        }
    //    }
    //
    //    /// whether to use smart quotes
    //    @IBInspectable var smartQuotes: Bool {
    //        get {
    //            return field.smartQuotesType == .yes
    //        }
    //        set {
    //            if newValue {
    //                field.smartQuotesType = .yes
    //            } else {
    //                field.smartQuotesType = .no
    //            }
    //        }
    //    }
    
    /// whether to use spell checking
    @IBInspectable public var spellChecking: Bool {
        get {
            return field.spellCheckingType == .yes
        }
        set {
            if newValue {
                field.spellCheckingType = .yes
            } else {
                field.spellCheckingType = .no
            }
        }
    }
    
    /// whether to use dark or light mode of the board
    @IBInspectable public var isDark: Bool {
        get {
            return field.keyboardAppearance == .dark
        }
        set {
            if newValue {
                field.keyboardAppearance = .dark
            } else {
                field.keyboardAppearance = .light
            }
        }
    }
    
    /// The type of capitalization to use in the textfield.
    /// Note: the value must match one of the values in
    ///       the default interface bulder dropdown for UITextField
    @IBInspectable public var capitalization: String {
        get {
            return String(describing: field.autocapitalizationType)
        }
        set {
            let options = ["none", "words", "sentences", "all"]
            guard let rawValue = options.index(of: newValue.lowercased()) else {
                field.autocapitalizationType = .none
                return
            }
            field.autocapitalizationType = UITextAutocapitalizationType(rawValue: rawValue)!
        }
    }
    
    /// The type of keyboard to use in the textfield.
    /// Note: the value must match one of the values in
    ///       the default interface bulder dropdown for UITextField
    @IBInspectable public var keyboardType: String {
        get {
            return String(describing: field.keyboardType)
        }
        set {
            let options = ["default", "ascii", "numbers", "url", "number pad",
                           "phone pad", "name pad", "email", "decimal pad",
                           "twitter", "web search", "ascii number", "alphabet"]
            guard let rawValue = options.index(of: newValue.lowercased()) else {
                field.keyboardType = .default
                return
            }
            field.keyboardType = UIKeyboardType(rawValue: rawValue)!
        }
    }
    
    /// The return key to use in the keyboard.
    /// Note: the value must match one of the values in
    ///       the default interface bulder dropdown for UITextField
    @IBInspectable public var returnKey: String {
        get {
            return String(describing: field.returnKeyType)
        }
        set {
            let options = [ "default", "go", "google", "join", "next", "route",
                            "search", "send", "yahoo", "done", "emergency call",
                            "continue" ]
            guard let rawValue = options.index(of: newValue.lowercased()) else {
                field.returnKeyType = .default
                return
            }
            field.returnKeyType = UIReturnKeyType(rawValue: rawValue)!
        }
    }
    
    /// a convenience for dismissing keyboards that are doneable
    @IBInspectable var isDimissOnReturnPressEnabled: Bool = false
    
    /// Setup the view after its rendered from the storyboard file
    override open func awakeFromNib() {
        super.awakeFromNib()
        card.delegate = self
    }
    
    /// Focus the view
    override open func becomeFirstResponder() -> Bool {
        return field.becomeFirstResponder()
    }
    
    /// Release focus on the view
    override open func resignFirstResponder() -> Bool {
        return field.resignFirstResponder()
    }
    
}



// MARK: Material Card Delegate Functions
extension MaterialTextField: MaterialCardDelegate {
    
    /// Handle a tap to a card
    /// - parameters:
    ///   - card: the card that was selected
    func didTap(_ card: MaterialCard) {
        field.becomeFirstResponder()
    }
    
}



// MARK: Text Field Delegate Functions
extension MaterialTextField: UITextFieldDelegate {
    
    /// Tell the keyboard to dismiss when the user presses return
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if isDimissOnReturnPressEnabled {
            textField.resignFirstResponder()
        }
        return false
    }
    
}
