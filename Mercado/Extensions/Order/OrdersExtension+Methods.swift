//
//  OrdersExtension+Methods.swift
//  Mercado
//
//  Created by Dina ElShabassy on 6/13/21.
//

import Foundation
import UIKit

extension OrdersViewController{
    
    func onSuccessUpdateView(){
        ordersArray = ordersViewModel.ordersArray
        //print(ordersArray)
        DispatchQueue.main.async {
            self.hideLoading(activityIndicator: self.activityIndicator)
            self.orderTableView.reloadData()
        }
    }
    
    func onFailUpdateView(){
        self.hideLoading(activityIndicator: self.activityIndicator)
        let alert = UIAlertController(title: "Error", message: ordersViewModel.showError, preferredStyle: .alert)

        let okAction  = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in

        }

        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func onEmptyOrderView(){
         DispatchQueue.main.async {
            self.hideLoading(activityIndicator: self.activityIndicator)
            self.noOrdersImage.isHidden = false
            self.noOrdersLabel.isHidden = false
        }
    }
    
    func convertTimestampToDate(timeStamp : Int) -> String {
        
        let date = Date(timeIntervalSince1970: TimeInterval(timeStamp))
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
    
}
