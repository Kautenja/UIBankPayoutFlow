//
//  CompanyInformationVC.swift
//  UIStripeCustomPayoutFlow
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
class CompanyInformationVC: UIViewController {
    
    /// the delegate to pass events to if any
    var delegate: CompanyInformationVCDelegate?

    /// the company to mutate with the form
    var company = Company()
    
    /// the tableview housing the data entry cells
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.contentInset = UIEdgeInsetsMake(0, 0, 300, 0)
        }
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
    
    /// Respond to a press on the continue button
    @IBAction func didPressContinue() {
        delegate?.didFill(self, company: company)
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
    
}



// MARK: Table View functions
extension CompanyInformationVC: UITableViewDelegate, UITableViewDataSource {
    
    /// Dequeue the correct cell based on the static mapping and return it
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: cellIDs[indexPath.row]!, for: indexPath)
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
