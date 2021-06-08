//
//  Cart.swift
//  Mercado
//
//  Created by Mayar Adel on 6/2/21.
//

import UIKit

struct Cart {
    var cartHandlerViewModel = CartHandlerViewModel()
    
    
    
//    //to change button color
//    func checkIfItemInCart(button :UIButton,itemId:String)   {
//        cartHandlerViewModel.checkIfItemInCart(currentCartId:itemId)
//        print("change color \(itemId)")
//        cartHandlerViewModel.bindIfItemInCartToView = {
//            itemExist in
//            if itemExist {
////                DispatchQueue.main.async {
////
////                    button.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.3764705882, blue: 0.2470588235, alpha: 1)
////                   button.setImage(UIImage(systemName: "checkmark"), for: .normal)
////                }
//                print("item exist")
//            }
//            else{
//                print("not found in cart from struct")
//            }
//        }
//    }
 
    func addToCart(sender :UIButton,item:CartItem,itemId:String,currentView:UIViewController)  {
        
        cartHandlerViewModel.checkIfItemInCart(currentCartId:itemId)
        cartHandlerViewModel.bindIfItemInCartToView = {
                   itemExist in
                   if itemExist {
                    self.cartHandlerViewModel.removeItemFromCart(itemId:itemId)
                    self.cartHandlerViewModel.getNumbersOfItemsInCart()
                    print("not found in cart from struct")
                //    sender.backgroundColor = #colorLiteral(red: 0.3254901961, green: 0.6941176471, blue: 0.4588235294, alpha: 1)
                    DispatchQueue.main.async {
                        currentView.showToast(message: "item removed from cart", font:  .systemFont(ofSize: 16.0))
                       
                    }
                    
                 
                 print("removed vm")
                   }
                   else{
                    
                    print("item exist")
                    self.cartHandlerViewModel.addItemToCart(cartItem: item)
                    self.cartHandlerViewModel.getNumbersOfItemsInCart()
                    DispatchQueue.main.async {
                        currentView.showToast(message: "item added to cart", font:  .systemFont(ofSize: 16.0))
                    }
                    
                    
                    print("cart added \(item.itemId!)")
                    
                   }
               }
//        if sender.backgroundColor !=  #colorLiteral(red: 0.9529411765, green: 0.3764705882, blue: 0.2470588235, alpha: 1){
//            sender.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.3764705882, blue: 0.2470588235, alpha: 1)
//            sender.setImage(UIImage(systemName: "checkmark"), for: .normal)
//            cartHandlerViewModel.addItemToCart(cartItem: item)
//            print("cart added \(item.itemId!)")
//
//        }
//        else
//        {
//         //   sender.backgroundColor = #colorLiteral(red: 0.3254901961, green: 0.6941176471, blue: 0.4588235294, alpha: 1)
//         //   sender.setImage(UIImage(systemName: "cart.badge.plus.fill"), for: .normal)
//            cartHandlerViewModel.removeItemFromCart(itemId:itemId)
//        }
    }
}
