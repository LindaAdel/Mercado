//
//  Cart.swift
//  Mercado
//
//  Created by Mayar Adel on 6/2/21.
//

import UIKit

struct Cart {
    var cartHandlerViewModel = CartHandlerViewModel()
    
    
    

 
    func addToCart(sender :UIButton,item:CartItem,itemId:String,currentView:UIViewController)  {
        
        cartHandlerViewModel.checkIfItemInCart(currentCartId:itemId)
        cartHandlerViewModel.bindIfItemInCartToView = {
                   itemExist in
                   if itemExist {
                    self.cartHandlerViewModel.removeItemFromCart(itemId:itemId)
                    self.cartHandlerViewModel.getNumbersOfItemsInCart()
                   
           
                    DispatchQueue.main.async {
                        currentView.showToast(message: "item removed from cart", font:  .systemFont(ofSize: 16.0))
                       
                    }
                    
                 
            
                   }
                   else{
                    
               
                    self.cartHandlerViewModel.addItemToCart(cartItem: item)
                    self.cartHandlerViewModel.getNumbersOfItemsInCart()
                    DispatchQueue.main.async {
                        currentView.showToast(message: "item added to cart", font:  .systemFont(ofSize: 16.0))
                    }
                    
                    
                  
                    
                   }
               }

    }
}
