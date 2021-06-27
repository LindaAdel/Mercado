//
//  NewArrivalService.swift
//  Mercado
//
//  Created by Dina ElShabassy on 5/25/21.
//

import Foundation
import Firebase

class NewArrivalService : FirebaseProtocol{
    
    var ref: DatabaseReference! = Database.database().reference()
    var newArrival_array = [SpecialItem]()
    
    func fetchArrayOfSpecialItems(completion: @escaping ([SpecialItem]?, Error?) -> ()) {
        self.ref.child("new arrival").getData { (error, snapshot) in
            self.newArrival_array.removeAll()
            if let error = error {
                print(error)
            }
            else if snapshot.exists() {
                let data = snapshot.value as? [String:NSDictionary]
                data!.forEach{ item in
                    let itemObj =  item.value
                    
                    let newArrivalObj = SpecialItem()
                    newArrivalObj.category = itemObj["category"] as? String
                    newArrivalObj.itemId = itemObj["itemId"] as? String
                    newArrivalObj.subCategory = itemObj["subCategory"] as? String
                    
                    self.newArrival_array.append(newArrivalObj)
                    
                }
               
                completion(self.newArrival_array,nil)
            }
            else {
                
                completion(nil,error)

            }
        }
    }

}

