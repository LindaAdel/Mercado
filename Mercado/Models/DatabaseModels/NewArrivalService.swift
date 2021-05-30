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
            if let error = error {
                print("Error getting data \(error)")
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
                print(self.newArrival_array.count)
                completion(self.newArrival_array,nil)
            }
            else {
                print("No data available")
                completion(nil,error)

            }
        }
    }

}

