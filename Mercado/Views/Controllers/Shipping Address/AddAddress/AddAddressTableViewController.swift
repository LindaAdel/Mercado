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
    var addressesArray : [Address] = []
    var noAddressesLabel: UILabel!
    var addressViewModel :AddressViewModel!
    @objc func backButton() {
        self.navigationController?.popToRootViewController(animated: true)
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.showNoAddressLabel()
        if addressesArray.count != 0
        {
            noAddressesLabel.isHidden = true
        }
        //initialize address vm
        addressViewModel = AddressViewModel()
        
        //get address from fb
        if addressesArray.count == 0 //to check if came from details vc
        {
            addressViewModel.getAddressFromFB()
            addressViewModel.bindAddressToAddAddressView = {
                [self]  address in
                print("view address")
                
                DispatchQueue.main.async {
                    
                    addressesArray.append(address!)
                    self.tableView.reloadData()
                    noAddressesLabel.isHidden = true
                    
                }
            }
        }
        //add tableview height zero to hide emty cell
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        //add floating button over tableview
        self.showFloatingButton()
        
        self.navigationItem.title = "Addresses"
        self.navigationItem.backButtonTitle = ""
        let newBackButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward") , style: UIBarButtonItem.Style.plain, target: self, action: #selector(backButton))
        
        self.navigationItem.leftBarButtonItem = newBackButton
        
        
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
        
        cell.addressLabel.text = "\(addressesArray[indexPath.row].street! ), \(addressesArray[indexPath.row].area!), \(addressesArray[indexPath.row].governorate!)\("\n")Mobile Number  (\(addressesArray[indexPath.row].mobileNumber!))"
        
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete
        {
            
            
            addressesArray.remove(at: indexPath.row)
            //delete address from fb
            addressViewModel.removeAddressFromFb()
            // Delete the row from tableview
            tableView.deleteRows(at: [indexPath], with: .fade)
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
    //to edit address
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let addressDetailsVC = storyboard?.instantiateViewController(withIdentifier: String(describing: AddressDetailsViewController.self)) as! AddressDetailsViewController
        addressDetailsVC.address = addressesArray[indexPath.row]
        self.navigationController?.pushViewController(addressDetailsVC, animated: true)
    }
}

