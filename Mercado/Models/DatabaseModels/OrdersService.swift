//
//  OrdersService.swift
//  Mercado
//
//  Created by Dina ElShabassy on 6/12/21.
//

import Foundation
import Firebase

class OrdersService {
    
    var ref: DatabaseReference! = Database.database().reference()
    let userID = Auth.auth().currentUser?.uid
    var ordersArray = [Order]()
    var orderItemsArray = [CartItem]()
    
    func fetchArrayOfOrders(completion: @escaping ([Order]?, Error?) -> ()) {
        self.ref.child("orders").child(userID!).getData { (error, snapshot) in
            self.ordersArray.removeAll()
            self.orderItemsArray.removeAll()
            if let error = error {
                print(error)
            }
            else if snapshot.exists() {
                let data = snapshot.value as? [String:NSDictionary]
                data!.forEach{ item in
                    let itemObj =  item.value
                    let orderObj = Order()
                    orderObj.totalPrice = itemObj["totalPrice"] as? Float
                    orderObj.shippingAddress = itemObj["shippingAddress"] as? String
                    orderObj.timeStamp = itemObj["timestamp"] as? Int
                    orderObj.orderNumber = item.key
                    let orderItemsArray = itemObj["items"] as? [NSDictionary]
                    
                    orderItemsArray!.forEach { item in
                        let orderItemObj = CartItem()
                        orderItemObj.count = item["count"] as? Int
                        orderItemObj.itemId = item["itemId"] as? String
                        self.orderItemsArray.append(orderItemObj)
                    }

                    orderObj.items = self.orderItemsArray
                    self.orderItemsArray.removeAll()
                 
                    self.ordersArray.append(orderObj)
                   
                    
                }
                completion(self.ordersArray,nil)
            }
            else {
           
                completion(nil,error)

            }
        }
    }
    
    func searchForItemInAllItems(itemId : String ,completion: @escaping (AllItems?, Error?) -> () ){
        
         self.ref.child("allItems").child(itemId).getData { (error, snapshot) in
                       
                       if let error = error {
                           print(error)
                       }
                       else if snapshot.exists() {
                           let data = snapshot.value as? NSDictionary
                        
                           let allItemsObj = AllItems()
                            allItemsObj.item_image = data!["item_image"] as? String
                            allItemsObj.item_price = data!["item_price"] as? String
                            allItemsObj.item_title = data!["item_title"] as? String
                            allItemsObj.category = ""
                            allItemsObj.itemId = ""
                            allItemsObj.subCategory = ""
                           
                           completion(allItemsObj,nil)
                       }
                       else {
                         
                           completion(nil,error)
                           
                       }
                   }
        
    }
    
}
