//
//  skinCarePojo.swift
//  Mercado
//
//  Created by Linda adel on 5/17/21.
//

import Foundation
import UIKit

class SkinCare : ItemProtocol,Codable {
    
    
//    var color: String? //to conform not more
    
    
   
    var item_image: String?
    var item_price :String?
    var item_rating :String?
    var item_title : String?
    var item_id: String?
    var brand : String?
    var item_description : String?
    var type :String?
    var slider_images :[String]?
    var size : String?
    var recommended_use : String?
    var texture : String?
    var price_afterSale : String?
    
//    enum CodingKeys: String, CodingKey {
//
//           case item_rating,item_title, item_image, item_price,
//                brand,slider_images,item_id,item_description,type
//        ,size,recommended_use,texture
//    }
    
    
}
