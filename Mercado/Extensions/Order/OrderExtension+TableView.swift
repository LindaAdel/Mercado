//
//  OrderExtension+TableView.swift
//  Mercado
//
//  Created by Dina ElShabassy on 6/9/21.
//

import Foundation
import UIKit

extension OrdersViewController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    // Make the background color show through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 150
       }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? OrderTableViewCell
        cell?.layer.cornerRadius = 15

        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let checkoutVC = storyboard?.instantiateViewController(identifier: "OrderDetails") as! CheckoutViewController
        checkoutVC.modalPresentationStyle = .fullScreen
//        checkoutVC.total.text = "Order"
//        checkoutVC.itemsArray = itemsArray!
//        checkoutVC.cartItemsArray = cartItemsArray!
        checkoutVC.subTotal = 554.3
        checkoutVC.totalPrice = 3.4
        checkoutVC.orderNumber = "jjwijei9873he"
        checkoutVC.timeStamp = "Nov 4,1997"
        self.present(checkoutVC, animated: true, completion: nil)
    }
    
}
