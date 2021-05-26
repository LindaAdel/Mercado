//
//  mobilesPojo.swift
//  Mercado
//
//  Created by Linda adel on 5/17/21.
//

import Foundation
import UIKit

class Laptops : Codable ,ItemProtocol {
  //  var type: String?//to conform
    
    
    var item_image: String?
    var item_price :String?
    var item_title : String?
    var item_id: String?
    var color : String?
    var brand : String?
    var slider_images :[String]?
    var display_size :String?
    var model : String?
    var processor : String?
    var operating_system : String?
    var ram : String?
    var storage :String?
   
//    enum CodingKeys: String, CodingKey {
//
//           case item_image,
//                item_price ,
//                item_title,
//                item_id,
//                color ,
//                brand ,
//                slider_images ,
//                display_size,
//                model ,
//                processor ,
//                operating_system ,
//                ram ,
//                storage
//    }
}
