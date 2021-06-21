//
//  FavoriteService.swift
//  Mercado
//
//  Created by Linda adel on 5/23/21.
//

import Foundation
import Firebase

class FavoriteService : FirebaseProtocol{
    
    var ref : DatabaseReference! = Database.database().reference()
    let userID = Auth.auth().currentUser?.uid
    var firebaseFavArray = [SpecialItem]()

    
    func fetchArrayOfSpecialItems(completion: @escaping ([SpecialItem]?, Error?) -> ()) {
           self.ref.child("favorite").child(userID!).getData { (error, Datasnapshot) in
              self.firebaseFavArray.removeAll()
              if let error = error {
                  completion(nil , error)
              print("Error getting data \(error)")
              }
              else if Datasnapshot.exists() {
              let data = Datasnapshot.value as? [String : NSDictionary]
              data!.forEach{ item in
              let favDataObj = item.value

                let favObj = SpecialItem()
                  favObj.category = favDataObj["category"] as? String
                  favObj.itemId = favDataObj["itemId"] as? String
                  favObj.subCategory = favDataObj["subCategory"] as? String
                  print(favObj)
                  self.firebaseFavArray.append(favObj)
           
                }
                  completion(self.firebaseFavArray,nil)
              
              }
              else {
              print("No data available")
                completion(nil,nil)
                 }
               }
       }
       
                
}


