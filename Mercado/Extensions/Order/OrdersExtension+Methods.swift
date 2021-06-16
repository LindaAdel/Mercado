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
            self.orderTableView.reloadData()
        }
    }
    
    func onFailUpdateView(){
        let alert = UIAlertController(title: "Error", message: ordersViewModel.showError, preferredStyle: .alert)

        let okAction  = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in

        }

        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func onEmptyOrderView(){
         DispatchQueue.main.async {
            self.noOrdersImage.isHidden = false
            self.noOrdersLabel.isHidden = false
        }
    }
    
}
