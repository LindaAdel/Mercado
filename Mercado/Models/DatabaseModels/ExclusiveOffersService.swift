//
//  ExclusiveOffersService.swift
//  Mercado
//
//  Created by Dina ElShabassy on 5/25/21.
//

import Foundation
import Firebase

class ExclusiveOffersService : FirebaseProtocol{
    
    var ref: DatabaseReference! = Database.database().reference()
    var offersArray = [NewArrival]()
    
    func fetchArrayOfItems(completion: @escaping ([NewArrival]?, Error?) -> ()) {
        self.ref.child("offers").getData { (error, snapshot) in
                if let error = error {
                    print("Error getting data \(error)")
                }
                else if snapshot.exists() {
                    let data = snapshot.value as? [String:NSDictionary]
                    data!.forEach{ item in
                        let itemObj =  item.value
                        
                        let newArrivalObj = NewArrival()
                        newArrivalObj.category = itemObj["category"] as? String
                        newArrivalObj.itemId = itemObj["itemId"] as? String
                        newArrivalObj.subCategory = itemObj["subCategory"] as? String
                        
                        self.offersArray.append(newArrivalObj)
                        
                    }
                    print(self.offersArray.count)
                    completion(self.offersArray,nil)
                }
                else {
                    print("No data available")
                    completion(nil,error)

                }
            }
        }
    
    
    
       
    
//    func fetchNewArrivalItem(newArrivalItem : NewArrival, completion : @escaping (NSDictionary?, Error?)->()){
//    
//        self.ref.child("categories")
//            .child(newArrivalItem.category!)
//            .child(newArrivalItem.subCategory!)
//            .child(newArrivalItem.itemId!)
//            .getData { (error, snapshot) in
//                
//            if let error = error {
//                print("Error getting data \(error)")
//            }
//            else if snapshot.exists() {
//                let data = snapshot.value as? NSDictionary
//                print(data!)
//                
////                pojoClass.item_title = data!["item_title"] as? String
////                newArrivalObj.itemId = itemObj["itemId"] as? String
////                newArrivalObj.subCategory = itemObj["subCategory"] as? String
//
////                self.newArrival_array.append(newArrivalObj)
//
//                completion(data,nil)
//            }
//            else {
//                print("No data available")
//                completion(nil,error)
//
//            }
//        }
//    }
}
