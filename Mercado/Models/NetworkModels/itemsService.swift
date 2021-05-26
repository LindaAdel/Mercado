//
//  networkModel.swift
//  Mercado
//
//  Created by Linda adel on 5/18/21.
//

import Foundation
import Alamofire
import Firebase 


class itemsService{
    
    var ref : DatabaseReference! = Database.database().reference()
    let userID = Auth.auth().currentUser?.uid
    let favorite : String = "favorite"
    
    func fetchItemsData<T:Codable>(of:T.Type,url:String,completion : @escaping (T?, Error?)->()){

        AF.request(url)
                .validate()
            .responseDecodable(of: T.self) { (response) in
                    switch response.result {
                    case .success( _):
                       if let items = response.value {
                        completion(items,nil)

                       }

                    
                    case .failure(let error):
                        print(error)
                        completion(nil , error)
        
        
                    }
                }
    }
    func  addItemsToFavorites(favoriteItem : Favorite){
       
        let itemId = favoriteItem.item_id
        let category = favoriteItem.categoryName
        let subCategory = favoriteItem.subcategoryName
        self.ref.child("\(favorite)/\(userID!)/\(itemId!)/itemId").setValue(itemId!)
        self.ref.child("\(favorite)/\(userID!)/\(itemId!)/category").setValue(category!)
        self.ref.child("\(favorite)/\(userID!)/\(itemId!)/subCategory").setValue(subCategory!)
      
    }
    func  removeItemsFromFavorites(favoriteItem : Favorite){
            let itemId = favoriteItem.item_id
            ref?.child("favorite").child(userID!).child(itemId!).removeValue()
        }
    
}
