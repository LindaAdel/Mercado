//
//  AllItemsSearchService.swift
//  Mercado
//
//  Created by Dina ElShabassy on 6/10/21.
//

import Foundation
import Firebase

class AllItemsSearchService {
    
    var ref: DatabaseReference! = Database.database().reference()
    var filteredArray = [AllItems]()
    
     //filterAllItemsArray
        func filterAllItemsArray(searchName : String,completion: @escaping ([AllItems]?, Error?) -> ()) {
           
            let dbReference = ref.child("allItems").queryOrdered(byChild: "item_title").queryStarting(atValue: searchName.uppercased()).queryEnding(atValue: searchName.lowercased()).queryLimited(toFirst: 5)

            dbReference.observe(.value, with:{ (snapshot: DataSnapshot) in
                self.filteredArray.removeAll()
             
                if snapshot.exists() {
                    let data = snapshot.value as? [String:NSDictionary]
                    //print(data!)
                    data!.forEach{ item in
                        let itemObj =  item.value
    
                        let allItemsObj = AllItems()
                        allItemsObj.category = itemObj["category"] as? String
                        allItemsObj.itemId = itemObj["itemId"] as? String
                        allItemsObj.subCategory = itemObj["subCategory"] as? String
                        allItemsObj.item_image = itemObj["item_image"] as? String
                        allItemsObj.item_price = itemObj["item_price"] as? String
                        allItemsObj.item_title = itemObj["item_title"] as? String
    
                        self.filteredArray.append(allItemsObj)
                    }
                    completion(self.filteredArray,nil)
                }
                else {
                        print("No data available")

                    }
            
            
        })

    }
    
}
