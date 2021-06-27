//
//  CartMethodsExtension.swift
//  Mercado
//
//  Created by Mayar Adel on 6/3/21.
//

import Foundation
import UIKit
extension CartViewController
{
    //MARK:- Cart badge observer
    func observeToCartBadge()  {
        NotificationCenter.default.addObserver(self,selector:#selector(updateBadgeValue(_:)),name:NSNotification.Name(rawValue: "cartBadge"),object:nil)
    }
    @objc func updateBadgeValue(_ notifications:Notification)
    {
        if let data = notifications.userInfo
        {
            let numberOfItemsInCart = data["numberOfItems"] as! Int
            if numberOfItemsInCart == 0
            {
                cartTabBarIcon.badgeValue = nil
            }
            else
            {
            cartTabBarIcon.badgeValue = String(numberOfItemsInCart)
            }
         
           
        }
    }
    //MARK:- Count Observer
    func observeToCountValue()  {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView(_:)), name: NSNotification.Name(rawValue: "countObserver"), object: nil)
    }
    //to update values when count value updated
    @objc func reloadTableView(_ notifications:Notification) {
        cartViewModel.getCartItems()
        
    }

    func emptyCart()   {
        cartViewModel.bindEmptyCartToView =
            { [self] in
              
                DispatchQueue.main.async {
                    self.hideLoading(activityIndicator: self.activityIndicator)
                    self.emptyCartImage.isHidden = false
                }
            
            }
       
    }
    
    func reloadCartData()  {
        cartViewModel.bindCartItemsToView =
            {
                [self](items,cartItems) in
                
                
                self.itemsArray = items
                self.cartItemsArray = cartItems
                self.subTotalValue = 0.0
                var count = 0
                
                for item in self.itemsArray {
                    if count < cartItems.count
                    {
                        self.subTotalValue += Float(item.item_price!)! * Float(cartItems[count].count!)
                        count += 1
                    }
                    
                    
                }
                
        
                DispatchQueue.main.async {
                    self.hideLoading(activityIndicator: self.activityIndicator)
                    self.emptyCartImage.isHidden = true
                    self.tableView.reloadData()
                    self.subTotalLabel.text = "\(String(describing: self.subTotalValue!)) EGP"
                    self.totalValue = self.shippingValue!
                        + self.subTotalValue
                    self.totalValueLabel.text = "\(self.totalValue!) EGP"
                 
                }
                
                
            }
    }
}
// to change delete button color and size 
extension UIImage {
    func colored(in color: UIColor) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 100, height: 100))
        return renderer.image { context in
            color.set()
            self.withRenderingMode(.alwaysTemplate).draw(in: CGRect(x: 20, y: 20, width: 50, height: 70))
        }
    }
}
