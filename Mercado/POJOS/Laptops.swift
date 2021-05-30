//
//  mobilesPojo.swift
//  Mercado
//
//  Created by Linda adel on 5/17/21.
//

import Foundation
import UIKit

class Laptops : Codable ,ItemProtocol {
 
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
    var price_afterSale : String?
   

}
