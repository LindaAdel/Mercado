//
//  CartViewModel.swift
//  Mercado
//
//  Created by Mayar Adel on 6/1/21.
//

import Foundation
class CartViewModel {
    var firebaseManager : FirebaseManager!
    var cartItems:[ItemProtocol]!
    var bindCartItemsToView :(([ItemProtocol],[CartItem])->())!
    var bindEmptyCartToView :(()->())!
    init() {
        firebaseManager = FirebaseManager.shared
        cartItems = []
    }
  
    func removeCartItemFromFirebase(itemId:String)  {
        firebaseManager.removeItemfromFirebaseCart(itemId: itemId)
    }
    //get current items exists in firebase
    func getCartItems()
    {
        firebaseManager.getCartItemsFromFirebase()
        {
            cartItemsArray in
            guard cartItemsArray != nil
            else
            {
                print("vm empty cart")
                self.bindEmptyCartToView()
                return
            }
            self.searchItemInCartDetails(cartItemsArray: cartItemsArray!)
        }
    }
    //get every item in cart details
    func searchItemInCartDetails(cartItemsArray : [CartItem])
    {
        cartItems = []
        for itemData in cartItemsArray {
      //      print("num \(item.subCategory)")
            
            switch itemData.subCategory{
            
            case "beautyEquipment","hairStylers":
                firebaseManager.searchForItemsInCart(of:PersonalCare.self, cartItem: itemData)
                {
                    item in
            //        print("vm \(item?.item_title!)")
                    self.cartItems.append(item!)
                    self.bindCartItemsToView(self.cartItems,cartItemsArray)
                }
                
            case "microwaves","blendersAndMixers":
                firebaseManager.searchForItemsInCart(of:HomeAppliances.self, cartItem: itemData)
                {
                    item in
        //            print("vm \(item?.item_title)")
                    self.cartItems.append(item!)
                    self.bindCartItemsToView(self.cartItems,cartItemsArray)
                    
                }
           
            case "clothing":
                switch itemData.category {
                case "Girl's Fashion","boy's fashion":
                    firebaseManager.searchForItemsInCart(of:KidsClothing.self, cartItem: itemData)
                    {
                        item in
                   //     print("vm \(item!)")
                        self.cartItems.append(item!)
                        self.bindCartItemsToView(self.cartItems,cartItemsArray)
                    }
              
                case "Women's Fashion":
                    firebaseManager.searchForItemsInCart(of:WomenClothing.self, cartItem:itemData)
                    {
                        item in
                     //   print("vm \(item!)")
                        self.cartItems.append(item!)
                        self.bindCartItemsToView(self.cartItems,cartItemsArray)
                    }
                default:
                    print("no kids")
                }
            case "shoes":
                switch itemData.category {
                case "Girl's Fashion","boy's fashion":
                firebaseManager.searchForItemsInCart(of:KidsShoes.self, cartItem: itemData)
                {
                    item in
                  //  print("vm \(item!)")
                    self.cartItems.append(item!)
                    self.bindCartItemsToView(self.cartItems,cartItemsArray)
                }
             
                default:
                    print("no shoes")
                }
            case "bags":
                firebaseManager.searchForItemsInCart(of:WomenBags.self, cartItem: itemData)
                {
                    item in
                  //  print("vm \(item!)")
                    self.cartItems.append(item!)
                    self.bindCartItemsToView(self.cartItems,cartItemsArray)
                }
            case "makeUp":
                firebaseManager.searchForItemsInCart(of:MakeUp.self, cartItem: itemData)
                {
                    item in
                //    print("vm \(item!)")
                    self.cartItems.append(item!)
                    print("total \(self.cartItems.count)")
                    print(type(of: self.cartItems))
                    self.bindCartItemsToView(self.cartItems,cartItemsArray)
                }
            case "skinCare":
                print("skincare")
                firebaseManager.searchForItemsInCart(of:SkinCare.self, cartItem: itemData)
                {
                    item in
                  //  print("vm \(item!)")
                    self.cartItems.append(item!)
                    self.bindCartItemsToView(self.cartItems,cartItemsArray)
                }
            
            case "laptops":
                firebaseManager.searchForItemsInCart(of:Laptops.self, cartItem: itemData)
                {
                    item in
                   // print("vm \(item!)")
                    self.cartItems.append(item!)
                    self.bindCartItemsToView(self.cartItems,cartItemsArray)
                }
            case "laptopBags":
                firebaseManager.searchForItemsInCart(of:LaptopBags.self, cartItem: itemData)
                {
                    item in
                   // print("vm \(item!)")
                    self.cartItems.append(item!)
                    self.bindCartItemsToView(self.cartItems,cartItemsArray)
                }
            case "mobiles","tablets":
                firebaseManager.searchForItemsInCart(of:TabletsAndMobiles.self, cartItem: itemData)
                {
                    item in
                   // print("vm \(item!)")
                    self.cartItems.append(item!)
                    self.bindCartItemsToView(self.cartItems,cartItemsArray)
                    
                }
                
                
            default:
                print("no sub category found from cart vm \(itemData.subCategory!) \(itemData.category!)")
           
            }
           
           
        }
       
       
    }
}