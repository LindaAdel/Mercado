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
            print("badge \(numberOfItemsInCart)")
           
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
    //MARk:- show empty cart backround
    func updateEmptyCartUI()  {
    
        emptyCartbackgroundImage.isHidden = false
        emptyCartbackgroundImage.image = UIImage(named: "emptyCartbg")
        self.view.addSubview(emptyCartbackgroundImage)
    }
    func emptyCart()   {
        cartViewModel.bindEmptyCartToView =
            { [self] in
                print("empty cart view")
                DispatchQueue.main.async {
                    self.updateEmptyCartUI()
                }
            
            }
       
    }
    
    func reloadCartData()  {
        cartViewModel.bindCartItemsToView =
            {
                [self](items,cartItems) in
                
                self.itemsArray = items
                self.cartItemsArray = cartItems
                print("item array \(self.itemsArray.count)")
                print("item cart \(cartItems.count)")
                self.subTotalValue = 0.0
                var count = 0
                
                for item in self.itemsArray {
                    if count < cartItems.count
                    {
                        self.subTotalValue += Float(item.item_price!)! * Float(cartItems[count].count!)
                        count += 1
                    }
                    
                    
                }
                
                print("before total \(self.subTotalValue)")
                DispatchQueue.main.async {
                    self.emptyCartbackgroundImage.isHidden = true
                    self.tableView.reloadData()
                    print("cart table view reloaded")
                    self.subTotalLabel.text = "\(String(describing: self.subTotalValue!)) EGP"
                    print(self.shippingLabel.text!)
                    self.totalValue = self.shippingValue!
                        + self.subTotalValue
                    self.totalValueLabel.text = "\(self.totalValue!) EGP"
                    print("updata total \(self.subTotalValue!)")
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
