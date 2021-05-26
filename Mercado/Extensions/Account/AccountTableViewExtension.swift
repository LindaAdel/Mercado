//
//  AccountTableViewExtension.swift
//  Mercado
//
//  Created by Mayar Adel on 5/23/21.
//

import Foundation
import UIKit
import Firebase
extension AccountViewController:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountDetailsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing :AccountTableViewCell.self), for: indexPath) as! AccountTableViewCell
        cell.accountDetailsLabel.text = accountDetailsArray[indexPath.row]["name"]
        cell.accountDetailsIcon.image = UIImage(systemName: accountDetailsArray[indexPath.row]["icon"]!)
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          return 100
        
      }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(accountDetailsArray[indexPath.row]["name"])
        let name = accountDetailsArray[indexPath.row]["name"]!
        switch name {
        case "Shipping Address":
            print("shipping selectend")

            // In the above, you replaced the navigation controller with your destVC.
            let confrimAddressVc = storyboard?.instantiateViewController(identifier: String(describing: AddAddressTableViewController.self)) as! AddAddressTableViewController
          //  confrimAddressVc.modalPresentationStyle = .fullScreen
            print(self.navigationController)
            
            self.navigationController?.pushViewController(confrimAddressVc, animated: true)
//            self.present(confrimAddressVc, animated: true, completion: nil)
        case "Help" :
            print("helppp")
//            let userID = Auth.auth().currentUser?.uid
//            Database.database().reference().child("users").child(userID! ).updateChildValues(["photo": "userName"])
        default:
            print("no")
        }
    }
}
