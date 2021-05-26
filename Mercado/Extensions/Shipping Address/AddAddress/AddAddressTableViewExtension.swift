//
//  AddAddressTableViewExtension.swift
//  Mercado
//
//  Created by Mayar Adel on 5/25/21.
//

import Foundation
import UIKit
extension AddAddressTableViewController
{
    //MARK:- No addresses
    func showNoAddressLabel()
    {
        noAddressesLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
        //set font
        noAddressesLabel.font = UIFont.systemFont(ofSize: 20)
        noAddressesLabel.text = "No Addresses"
        //add label to the center
        noAddressesLabel.center = CGPoint(x: self.tableView.frame.width/2, y: self.tableView.frame.height/2)
        noAddressesLabel.textAlignment = .center
       
        self.view.addSubview(noAddressesLabel)
    }
    
    //MARK:- floating button
    func showFloatingButton()
    {
        addAddressFloatingButton = UIButton()
        //add plus icon to button
        addAddressFloatingButton.setImage(UIImage(systemName: "plus"), for: .normal)
        //rounded button
        addAddressFloatingButton.layer.cornerRadius = 30
      //  addAddressFloatingButton.layer.masksToBounds = true
        //button bg
        addAddressFloatingButton.backgroundColor = self.view.tintColor
        //to set icon color
        addAddressFloatingButton.tintColor = .white
        //button Action
        addAddressFloatingButton.addTarget(self, action: #selector(addAddressButtonAction(_:)), for: .touchUpInside)
        //add button to the subview
        self.view.addSubview(addAddressFloatingButton)
        //add constraints to the floating button
        self.floatingButtonConstraints()
    }
    //floating button Action
    @objc  func addAddressButtonAction(_ sender: UIButton){
        
    //open confirmed address view 
        let confirmAddressVc = storyboard?.instantiateViewController(identifier: String(describing: ConfirmAddressViewController.self)) as! ConfirmAddressViewController
        confirmAddressVc.addAddressDelegate = self
        self.navigationController?.pushViewController(confirmAddressVc, animated: true)

       }
    func floatingButtonConstraints()  {
        addAddressFloatingButton.translatesAutoresizingMaskIntoConstraints = false
        //set width constraint
        addAddressFloatingButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        //set height  constraint
        addAddressFloatingButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        //right constraint
        addAddressFloatingButton.rightAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.rightAnchor ,constant: -20).isActive = true
        //bottom constraint
        addAddressFloatingButton.bottomAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.bottomAnchor,constant: -10).isActive = true
    }
}
extension AddAddressTableViewController : IAddAddress
{
    //MARK:- confrom add Address protocol
    func setLocation(address: String) {
        addressesArray.append(address)
        noAddressesLabel.isHidden = true
        self.tableView.reloadData()
        print("all address \(addressesArray)")
    }
    
    
}
