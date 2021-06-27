//
//  ProductDetailsViewModel.swift
//  Mercado
//
//  Created by Mayar Adel on 6/1/21.
//

import Foundation
class CartHandlerViewModel
{
    var number :Int!
    var firebaseManager : FirebaseManager!
    //to check if item exist in fb return true
    var bindIfItemInCartToView:((Bool)->())!
    init() {
        firebaseManager = FirebaseManager.shared
    }
  
    //get current items exists in firebase to update cart badge
    func getNumbersOfItemsInCart()
    {
        firebaseManager.getCartItemsFromFirebase()
        {
            cartItemsArray in
            guard cartItemsArray != nil
            else
            {
           
                self.postNumberOfItemsInCart(numberOfItems :0)
                return
            }
            self.postNumberOfItemsInCart(numberOfItems : cartItemsArray!.count)
         
          
        }
    }
    // post observer to update cart badge number
    func postNumberOfItemsInCart(numberOfItems : Int) {
        NotificationCenter.default.post(name:NSNotification.Name(rawValue: "cartBadge"),object:nil,userInfo:["numberOfItems":numberOfItems])
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
   
    //check if item exist in fb cart to change button color
    func checkIfItemInCart(currentCartId:String) {
        firebaseManager.checkItemInCart(currentCartId:currentCartId )
            { itemIsExist in
            if itemIsExist
            {
          
                self.bindIfItemInCartToView(true)
            }else {
               
                self.bindIfItemInCartToView(false)
            }
        }
    }
}
