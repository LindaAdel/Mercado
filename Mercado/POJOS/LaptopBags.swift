//
//  laptopBagsPojo.swift
//  Mercado
//
//  Created by Linda adel on 5/17/21.
//

import Foundation
import UIKit

class LaptopBags : Codable ,ItemProtocol{
   // var type: String?//to conform
    
    
    var item_image: String?
    var item_price :String?
    var item_title : String?
    var item_id: String?
    var color : String?
    var brand : String?
    var slider_images :[String]?
    var model : String?
    var compatible_with : String?
    var warranty_years : String?
    var water_resistant : String?
    var price_afterSale : String?
 
//    enum CodingKeys: String, CodingKey {
//           
//        case  item_image,
//        item_price,
//         item_title,
//        item_id,
//         color ,
//         brand,
//        slider_images,
//        model,
//        compatible_with,
//      warranty_years,
//       water_resistant
//        
//       }
}
