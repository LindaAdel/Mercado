//
//  personalCarePojo.swift
//  Mercado
//
//  Created by Linda adel on 5/17/21.
//

import Foundation
import UIKit

class PersonalCare : ItemProtocol ,Codable{
    var brand: String?
    var type: String?
    let color : String?
    var item_features : String?
   // var item_brand : String?
    var item_title : String?
    var item_image: String?
    var item_price : String?
  //  var item_type :String?
    var model_number : String?
    var slider_images :[String]?
    var item_id: String?
    var price_afterSale : String?
    
    
    enum CodingKeys: String, CodingKey {
           case brand = "item_brand"
           case type = "item_type"
           case color,item_features,item_title, item_image, item_price,
        model_number,slider_images,item_id,price_afterSale
       }
//    init(item_title:String, item_image:String, item_price:String) {
//        self.item_image = item_image
//        self.item_price = item_price
//        self.item_title = item_title
//    }
//    required init(from decoder:Decoder) throws {
//            let values = try decoder.container(keyedBy: CodingKeys.self)
//            item_title = try values.decode(String.self, forKey: .item_title)
//        item_image = try values.decode(String.self, forKey: .item_image)
//        item_price = try values.decode(String.self, forKey: .item_price)
//        }

}
