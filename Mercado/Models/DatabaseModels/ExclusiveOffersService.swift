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
    var offersArray = [SpecialItem]()
    
    func fetchArrayOfSpecialItems(completion: @escaping ([SpecialItem]?, Error?) -> ()) {
        self.ref.child("offers").getData { (error, snapshot) in
            self.offersArray.removeAll()
                if let error = error {
                    print(error)
                }
                else if snapshot.exists() {
                    let data = snapshot.value as? [String:NSDictionary]
                    data!.forEach{ item in
                        let itemObj =  item.value
                        
                        let exclusiveOffersObj = SpecialItem()
                        exclusiveOffersObj.category = itemObj["category"] as? String
                        exclusiveOffersObj.itemId = itemObj["itemId"] as? String
                        exclusiveOffersObj.subCategory = itemObj["subCategory"] as? String
                        
                        self.offersArray.append(exclusiveOffersObj)
                        
                    }
                  
                    completion(self.offersArray,nil)
                }
                else {
                   
                    completion(nil,error)

                }
            }
        }
    
}
