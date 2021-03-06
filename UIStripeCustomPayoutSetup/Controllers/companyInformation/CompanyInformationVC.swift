//
//  CompanyInformationVC.swift
//  UIBankPayoutFlow
//
//  Created by James Kauten on 8/10/17.
//  Copyright © 2017 Christian Kauten. All rights reserved.
//

import UIKit

/// a protocol for interracting with events from the company information view
protocol CompanyInformationVCDelegate {
    
    /// Respond to a press on the get started button
    func didFill(_ on: CompanyInformationVC, company: Company)
    
}

/// the company information page for the flow
class CompanyInformationVC: UIViewController, MaterialAddressCardDelegate {
    
    /// the delegate to pass events to if any
    var delegate: CompanyInformationVCDelegate?

    /// the company to mutate with the form
    var company: Company!
    
    /// the tableview housing the data entry cells
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.contentInset = UIEdgeInsetsMake(0, 0, 190, 0)
            let tap = UITapGestureRecognizer(target: self, action: #selector(didTapTable))
            tableView.addGestureRecognizer(tap)
        }
    }
    
    /// Respond to a tap on the tableview
    func didTapTable() {
        view.endEditing(true)
    }
    
    /// Return the number of cells in the table view
    let numberOfCells = 10
    
    /// the mapping of cell index to its cell ID
    let cellIDs = [ 0 : "nameString",
                    1 : "name",
                    2 : "typeString",
                    3 : "type",
                    4 : "addressString",
                    5 : "address",
                    6 : "repString",
                    7 : "repName",
                    8 : "repSSN",
                    9 : "repDOB"]
    
    /// the mapping of cell index to its cell ID
    let cellHeights: [Int : CGFloat] = [ 0 : 34,
                                         1 : 50,
                                         2 : 34,
                                         3 : 50,
                                         4 : 34,
                                         5 : 150,
                                         6 : 34,
                                         7 : 50,
                                         8 : 50,
                                         9 : 50]
    
    /// the name of the company
    var name: MaterialTextField! {
        didSet {
            name.field.tintColor = UIBankPayoutFlow.tintColor
            name.setFieldEditingChangedHandler { (field) in
                self.company.name = field.text
            }
        }
    }
    
    /// the type of the company
    var companyType: UISegmentedControl! {
        didSet {
            companyType.tintColor = UIBankPayoutFlow.tintColor
            companyType.addTarget(self, action: #selector(companyTypeDidChange),
                                  for: UIControlEvents.valueChanged)
        }
    }
    
    /// Repond to the segmented control changing
    func companyTypeDidChange() {
        switch companyType.selectedSegmentIndex {
        case 0:
            company.type = .company
        case 1:
            company.type = .individual
        default:
            ()
        }
    }
    
    /// the companies address
    var address: MaterialAddressCard! {
        didSet {
            address.tintColor = UIBankPayoutFlow.tintColor
            address.delegate = self
        }
    }
    
    /// Respond to the address value changing to a prevalidated address
    /// - parameters:
    ///   - picker: the picker the event happened on
    ///   - address: the new address
    func addressDidChange(_ picker: MaterialAddressCard, address: String?) {
        company.address?.street = address
    }
    
    /// Respond to the address value changing to a prevalidated address
    /// - parameters:
    ///   - picker: the picker the event happened on
    ///   - city: the new city
    func cityDidChange(_ picker: MaterialAddressCard, city: String?) {
        company.address?.city = city
    }
    
    /// Respond to the address value changing to a prevalidated address
    /// - parameters:
    ///   - picker: the picker the event happened on
    ///   - state: the new state
    func stateDidChange(_ picker: MaterialAddressCard, state: String?) {
        company.address?.state = state
    }
    
    /// Respond to the address value changing to a prevalidated address
    /// - parameters:
    ///   - picker: the picker the event happened on
    ///   - zip: the new zip
    func zipDidChange(_ picker: MaterialAddressCard, zip: String?) {
        company.address?.zip = zip
    }
    
    /// the first name of the comapny representative
    var repFirst: MaterialTextField! {
        didSet {
            repFirst.field.tintColor = UIBankPayoutFlow.tintColor
            repFirst.field.delegate = self
            repFirst.setFieldEditingChangedHandler { (field) in
                self.company.representative?.firstName = field.text
            }
        }
    }
    
    /// the middle name of the comapny representative
    var repMiddle: MaterialTextField! {
        didSet {
            repMiddle.field.tintColor = UIBankPayoutFlow.tintColor
            repMiddle.field.delegate = self
            repMiddle.setFieldEditingChangedHandler { (field) in
                self.company.representative?.middleName = field.text
            }
        }
    }
    
    /// the last name of the comapny representative
    var repLast: MaterialTextField! {
        didSet {
            repLast.field.tintColor = UIBankPayoutFlow.tintColor
            repLast.field.delegate = self
            repLast.setFieldEditingChangedHandler { (field) in
                self.company.representative?.lastName = field.text
            }
        }
    }
    
    /// the last 4 digitst of the SSN of the comapny representative
    var repSSN: MaterialTextField! {
        didSet {
            repSSN.field.tintColor = UIBankPayoutFlow.tintColor
            repSSN.setFieldEditingChangedHandler { (field) in
                guard field.text!.characters.count <= 4 else {
                    let index = field.text!.index(field.text!.startIndex, offsetBy: 4)
                    field.text = field.text!.substring(to: index)
                    return
                }
                self.company.representative?.ssn = field.text
            }
        }
    }
    
    /// the date of birth of the comapny representative
    var repDOB: UIDatePicker! {
        didSet {
            repDOB.addTarget(self,
                             action: #selector(dobDidChange),
                             for: .valueChanged)
        }
    }
    
    /// Repond to a change in the date of birth of the company representative
    func dobDidChange() {
        company.representative?.dob = repDOB.date
    }
    
    /// Respond to a press on the continue button
    @IBAction func didPressContinue() {
        guard let _ = company.name else {
            PopupAlert.show(on: self,
                            title: "What's your company called?",
                            message: "you must provide a name for your compnany")
            return
        }
        guard let _ = company.address?.street else {
            PopupAlert.show(on: self,
                            title: "What street are you on?",
                            message: "you must provide the street your company is on")
            return
        }
        guard let _ = company.address?.city else {
            PopupAlert.show(on: self,
                            title: "What city are you in?",
                            message: "you must provide the city your company is in")
            return
        }
        guard let _ = company.address?.state else {
            PopupAlert.show(on: self,
                            title: "What state are you in?",
                            message: "you must provide the state your company is in")
            return
        }
        guard let _ = company.address?.zip else {
            PopupAlert.show(on: self,
                            title: "What's your zip code?",
                            message: "you must provide the zipcode your company is located in")
            return
        }
        guard let _ = company.representative?.firstName else {
            PopupAlert.show(on: self,
                            title: "What's your representative's first name?",
                            message: "you must provide the full name of your company representative")
            return
        }
        guard let _ = company.representative?.middleName else {
            PopupAlert.show(on: self,
                            title: "What's your representative's middle name?",
                            message: "you must provide the full name of your company representative")
            return
        }
        guard let _ = company.representative?.lastName else {
            PopupAlert.show(on: self,
                            title: "What's your representative's last name?",
                            message: "you must provide the full name of your company representative")
            return
        }
        guard let ssn = company.representative?.ssn, ssn.characters.count == 4 else {
            PopupAlert.show(on: self,
                            title: "What's your representative's social?",
                            message: "you must provide the last 4 digits of you representative's social security number")
            return
        }
        guard let _ = company.representative?.dob else {
            PopupAlert.show(on: self,
                            title: "What's your representative's date of birth?",
                            message: "you must provide the date of birth of your company representative")
            return
        }
        delegate?.didFill(self, company: company)
    }
    
    /// the continue button
    @IBOutlet weak var continueButton: ZFRippleButton! {
        didSet {
            continueButton.backgroundColor = UIBankPayoutFlow.buttonBackgroundColor
            continueButton.tintColor = UIBankPayoutFlow.tintColor
        }
    }
    
    /// Show a new instance of this view controller on top of the exisitng view
    /// controller
    /// - parameters:
    ///   - vc: the view controller to show on top of
    static func show(on vc: UIViewController) -> CompanyInformationVC {
        let name = String(describing: classForCoder())
        let bundle = Bundle(for: classForCoder())
        let storyboard = UIStoryboard(name: name, bundle: bundle)
        let welcomeVC = storyboard.instantiateInitialViewController() as! CompanyInformationVC
        vc.show(welcomeVC, sender: nil)
        return welcomeVC
    }
    
    // MARK: View Hierarchy
    
    /// Setup the view on load
    override func viewDidLoad() {
        // if there is no company to mutate, create one
        if company == nil {
            company = Company()
            // setup the default values as they will appear on view controllers
            company.type = .company
            company.address = Address()
            company.representative = Representative()
        }
    }
    
}



// MARK: Table View functions
extension CompanyInformationVC: UITableViewDelegate, UITableViewDataSource {
    
    /// Dequeue the correct cell based on the static mapping and return it
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIDs[indexPath.row]!, for: indexPath)
        // setup local references to the views in the cells
        if let cell = cell as? NameCell {
            name = cell.field
        }
        else if let cell = cell as? TypeCell {
            companyType = cell.segmentedControl
        }
        else if let cell = cell as? AddressCell {
            address = cell.card
        }
        else if let cell = cell as? RepresentativeNameCell {
            repFirst = cell.first
            repMiddle = cell.middle
            repLast = cell.last
        }
        else if let cell = cell as? RepresentativeSSNCell {
            repSSN = cell.field
        }
        else if let cell = cell as? RepresentativeDOBCell {
            repDOB = cell.picker
        }
        return cell
    }

    /// Return the number of cells in the table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfCells
    }

    /// Return the height for the cell at the given index path
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath.row]!
    }
    
}



// MARK: Text Field Delegate functions
extension CompanyInformationVC: UITextFieldDelegate {
    
    /// repond to a press on the return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case repFirst.field:
            _ = repMiddle.becomeFirstResponder()
        case repMiddle.field:
            _ = repLast.becomeFirstResponder()
        case repLast.field:
            _ = repSSN.becomeFirstResponder()
        default:
            ()
        }
        return false
    }
    
}
