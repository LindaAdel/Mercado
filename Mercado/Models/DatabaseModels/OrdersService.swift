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
                print("Error getting data \(error)")
            }
            else if snapshot.exists() {
                let data = snapshot.value as? [String:NSDictionary]
                data!.forEach{ item in
                    let itemObj =  item.value
                    //print(item.key)
                    let orderObj = Order()
                    orderObj.totalPrice = itemObj["totalPrice"] as? Float
                    orderObj.shippingAddress = itemObj["shippingAddress"] as? String
                    orderObj.timeStamp = itemObj["timestamp"] as? Int
                    orderObj.orderNumber = item.key
                    let orderItemsArray = itemObj["items"] as? [NSDictionary]
                    
                    orderItemsArray!.forEach { item in
                       // let itemObj = item.value
                        let orderItemObj = CartItem()
                        orderItemObj.count = item["count"] as? Int
                        orderItemObj.itemId = item["itemId"] as? String
                        self.orderItemsArray.append(orderItemObj)
                    }

                    orderObj.items = self.orderItemsArray
                    self.orderItemsArray.removeAll()
                    print(self.orderItemsArray)
                    self.ordersArray.append(orderObj)
                    print(self.ordersArray)
                    
                }
                completion(self.ordersArray,nil)
            }
            else {
                print("No data available")

                completion(nil,error)

            }
        }
    }
    
    func searchForItemInAllItems(itemId : String ,completion: @escaping (AllItems?, Error?) -> () ){
        
         self.ref.child("allItems").child(itemId).getData { (error, snapshot) in
                       
                       if let error = error {
                           print("Error getting data \(error)")
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
                           print("No data available")
                           completion(nil,error)
                           
                       }
                   }
        
    }
    
}
