//
//  FavoriteService.swift
//  Mercado
//
//  Created by Linda adel on 5/23/21.
//

import Foundation
import Firebase

class FavoriteService{
    
    var ref : DatabaseReference! = Database.database().reference()
    let userID = Auth.auth().currentUser?.uid
    var firebaseFav = [Favorite]()

    
    func fetchFavoriteData(completion : @escaping ([Favorite]?, Error?)->()){
                  
        self.ref.child("favorite").child(userID!).getData { (error, Datasnapshot) in
        if let error = error {
            completion(nil , error)
        print("Error getting data \(error)")
        }
        else if Datasnapshot.exists() {
        let data = Datasnapshot.value as? [String : NSDictionary]
        data!.forEach{ item in
        let favDataObj = item.value

            var favObj = Favorite()
            favObj.categoryName = favDataObj["category"] as? String
            favObj.item_id = favDataObj["itemId"] as? String
            favObj.subcategoryName = favDataObj["subCategory"] as? String
            print(favObj)
            self.firebaseFav.append(favObj)
            
          }
            completion(self.firebaseFav,nil)
        
        }
        else {
        print("No data available")
           
           }
         }
        }
    
    func searchForItemData(favoriteItem : Favorite , completion : @escaping (NSDictionary?, Error?)->()){
        self.ref.child("categories").child(favoriteItem.categoryName!).child(favoriteItem.subcategoryName!).child(favoriteItem.item_id!).getData { (error, Datasnapshot) in
        if let error = error {
           
        print("Error getting data \(error)")
        }
        else if Datasnapshot.exists() {
           // print(Datasnapshot)
       let data = Datasnapshot.value as? NSDictionary
          //  print(data!)
           completion(data!,nil)
        }
        else {
            print("No data available")
            completion(nil,error)
           
           }
         }
        }
   
    

    
                
    }


