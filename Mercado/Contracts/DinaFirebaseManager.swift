////
////  DinaFirebaseManager.swift
////  Mercado
////
////  Created by Dina ElShabassy on 5/25/21.
////
//
//import Foundation
//import Firebase
//
//class DinaFirebaseManager{
//    
//    var ref: DatabaseReference! = Database.database().reference()
//    let userID = Auth.auth().currentUser?.uid
//    let favorite : String = "favorite"
//        
//        func searchForItem(specialItem : SpecialItem, completion : @escaping (NSDictionary?, Error?)->()){
//        
//            self.ref.child("categories")
//                .child(specialItem.category!)
//                .child(specialItem.subCategory!)
//                .child(specialItem.itemId!)
//                .getData { (error, snapshot) in
//                    
//                if let error = error {
//                    print("Error getting data \(error)")
//                }
//                else if snapshot.exists() {
//                    let data = snapshot.value as? NSDictionary
//                    print(data!)
//
//                    completion(data,nil)
//                }
//                else {
//                    print("No data available")
//                    completion(nil,error)
//
//                }
//            }
//        }
//    
//    func  addItemsToFavorites(favoriteItem : SpecialItem){
//       
//        let itemId = favoriteItem.itemId
//        let category = favoriteItem.category
//        let subCategory = favoriteItem.subCategory
//        self.ref.child("\(favorite)/\(userID!)/\(itemId!)/itemId").setValue(itemId!)
//        self.ref.child("\(favorite)/\(userID!)/\(itemId!)/category").setValue(category!)
//        self.ref.child("\(favorite)/\(userID!)/\(itemId!)/subCategory").setValue(subCategory!)
//      
//    }
//    func  removeItemsFromFavorites(favoriteItem : SpecialItem){
//            let itemId = favoriteItem.itemId
//            ref?.child("favorite").child(userID!).child(itemId!).removeValue()
//        }
//    
//    func fetchItemIsFavoriteData(itemId : String ,completion : @escaping ( Bool , Error?)->()){
//       
//        self.ref.child("favorite").child(userID!).child(itemId).getData { (error, Datasnapshot) in
//       
//            if let error = error {
//                completion(false , error)
//                print("Error getting data \(error)")
//            }
//            else {
//                completion(Datasnapshot.exists(),nil)
//            }
//        
//    }
//       
//    }
//    
//}
//
//
