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
        return ordersArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
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
        
        cell?.orderNo.text = "Order #\(ordersArray[indexPath.row].orderNumber!)"
        let orderDate = convertTimestampToDate(timeStamp: ordersArray[indexPath.row].timeStamp!)
        cell?.orderTimeStamp.text = "Placed on \(orderDate)"
        cell?.orderTotalPrice.text = "EGP \(ordersArray[indexPath.row].totalPrice!)"

        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let checkoutVC = storyboard?.instantiateViewController(identifier: "OrderDetails") as! CheckoutViewController
        checkoutVC.modalPresentationStyle = .fullScreen
        showLoading(activityIndicator: activityIndicator)
        
        checkoutVC.orderObj = ordersArray[indexPath.row]
        checkoutVC.subTotal = ordersArray[indexPath.row].totalPrice! - 100.0
        checkoutVC.totalPrice = ordersArray[indexPath.row].totalPrice!
        let orderDate = convertTimestampToDate(timeStamp: ordersArray[indexPath.row].timeStamp!)
        checkoutVC.orderTimestamp = orderDate
        
        let itemsArray = ordersArray[indexPath.row].items
        checkConnectivity()
        if Connectivity.isConnectedToInternet{
            for item in itemsArray! {
                self.ordersViewModel.getItemInfo(itemId: item.itemId!)
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                checkoutVC.cartItemsArray = self.ordersArray[indexPath.row].items
                checkoutVC.ordersItemsArray = self.itemsInfoArray
                self.present(checkoutVC, animated: true, completion: nil)
                self.itemsInfoArray.removeAll()
            }
        }
        
    }
    
}
