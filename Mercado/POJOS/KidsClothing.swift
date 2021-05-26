//
//  girlsClothing.swift
//  Mercado
//
//  Created by Linda adel on 5/17/21.
//

import Foundation
import UIKit

class KidsClothing : Codable ,ItemProtocol {
    
    
    var type: String?//to conform
    
    var slider_images: [String]?
    
    var material : String?
    var item_image: String?
    var item_price :String?
    var item_title : String?
    var item_id: String?
    var color : String?
    var brand : String?
  //  var slider_image :[String]?
    // var quality : String? //material
    var size : String?
    var price_afterSale : String?
    enum CodingKeys: String, CodingKey {
           case slider_images = "slider_image"
         case material = "quality"
        case item_image,item_price,item_title,item_id,color,brand,size,price_afterSale
        
       }
  
 
}
