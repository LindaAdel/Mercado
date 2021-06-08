//
//  FlashSaleService.swift
//  Mercado
//
//  Created by Dina ElShabassy on 6/5/21.
//

import Foundation
import Firebase

class FlashSaleService {
    
    var ref: DatabaseReference! = Database.database().reference()
    var flashSaleArray = [FlashSale]()
    
    func fetchFlashSaleArraycompletion(completion: @escaping ([FlashSale]?, Error?) -> ()) {
    self.ref.child("flashSale").getData { (error, snapshot) in
        if let error = error {
            print("Error getting data \(error)")
        }
        else if snapshot.exists() {
            let data = snapshot.value as? [NSDictionary]
            data!.forEach{ item in

                let flashSaleObj = FlashSale()
                flashSaleObj.image = item.value(forKey: "image") as? String

                self.flashSaleArray.append(flashSaleObj)

            }
            
            completion(self.flashSaleArray,nil)
        }
        else {
            print("No data available")
            completion(nil,error)

            }
        }
    }
}
