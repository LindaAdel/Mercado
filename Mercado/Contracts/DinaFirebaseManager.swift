//
//  DinaFirebaseManager.swift
//  Mercado
//
//  Created by Dina ElShabassy on 5/25/21.
//

import Foundation
import Firebase

class DinaFirebaseManager{
    
    var ref: DatabaseReference! = Database.database().reference()
        
        func searchForItem(newArrivalItem : NewArrival, completion : @escaping (NSDictionary?, Error?)->()){
        
            self.ref.child("categories")
                .child(newArrivalItem.category!)
                .child(newArrivalItem.subCategory!)
                .child(newArrivalItem.itemId!)
                .getData { (error, snapshot) in
                    
                if let error = error {
                    print("Error getting data \(error)")
                }
                else if snapshot.exists() {
                    let data = snapshot.value as? NSDictionary
                    print(data!)

                    completion(data,nil)
                }
                else {
                    print("No data available")
                    completion(nil,error)

                }
            }
        }
    
}


