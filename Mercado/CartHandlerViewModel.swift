//
//  ProductDetailsViewModel.swift
//  Mercado
//
//  Created by Mayar Adel on 6/1/21.
//

import Foundation
class CartHandlerViewModel
{
    var firebaseManager : FirebaseManager!
    init() {
        firebaseManager = FirebaseManager.shared
    }
    
    //calling firebase to add item in cart in db
    func addItemToCart(cartItem : CartItem)
    {
        firebaseManager.addItemToFirebaseCart(cartItem: cartItem)
    }
    //calling firebase to delete item from cart in db
    func removeItemFromCart(itemId:String)
    {
       firebaseManager.removeItemfromFirebaseCart(itemId: itemId)
    }
    var bindIfItemInCartToView:((Bool)->())!
    func checkIfItemInCart(currentCartId:String) {
        firebaseManager.checkItemInCart(currentCartId:currentCartId )
            { found in
            if found
            {
            print("found in cart")
                self.bindIfItemInCartToView(true)
            }else {
                print("not in cart")
                self.bindIfItemInCartToView(false)
            }
        }
    }
}
