//
//  AddAddressTableViewController.swift
//  Mercado
//
//  Created by Mayar Adel on 5/24/21.
//

import UIKit

class AddAddressTableViewController: UITableViewController
{
    var addAddressFloatingButton : UIButton!
    var addressesArray : [String] = []
    var noAddressesLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //add tableview height zero to hide emty cell
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        //add floating button over tableview
        self.showFloatingButton()
        
        self.navigationItem.title = "Addresses"
        self.navigationItem.backButtonTitle = "Back"
       
        //show no address label
        self.showNoAddressLabel()
       
        
        print("didliad : \(addressesArray.count)")
   
        
    }
   



    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addressesArray.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AddAddressTableViewCell.self), for: indexPath) as! AddAddressTableViewCell

        cell.addressLabel.text = addressesArray[indexPath.row]

        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete
        {
            
            
            addressesArray.remove(at: indexPath.row)
            // Delete the row from tableview
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            //check if there is no addresses show no addresses
            if addressesArray.count == 0
            {
                noAddressesLabel.isHidden = false
            }
            else
            {
                noAddressesLabel.isHidden = true
            }
          
            
        }
    }
   
}

