//
//  homeAppliancesPojo.swift
//  Mercado
//
//  Created by Linda adel on 5/17/21.
//

import Foundation


class HomeAppliances :ItemProtocol ,Codable{
    
    var brand: String?
    var type: String?
    var color : String?
    var country : String?
    var item_features : String?
    var item_capacity :String?
    var item_title : String?
    var item_image: String?
    var item_price : String?
    var model_number : String?
    var power :String?
    var slider_images :[String]?
    var item_id: String?
    var oldPrice : String?
    
    enum CodingKeys: String, CodingKey {
        case type = "item_type"
        case item_features = "item_Features"
        case country,item_image,item_price,item_title,item_id,color,item_capacity,model_number,power,
             slider_images,oldPrice,brand
        
       }
}
