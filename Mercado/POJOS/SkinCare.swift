//
//  skinCarePojo.swift
//  Mercado
//
//  Created by Linda adel on 5/17/21.
//

import Foundation
import UIKit

struct SkinCare : Codable,ItemProtocol {
   
    var item_image: String?
    var item_price :String?
    var item_rating :String?
    var item_title : String?
    var item_id: String?
    var brand : String?
    var item_description : String?
    var type :String?
    var slider_images :[String?]
    var size : String?
    var recommended_use : String?
    var texture : String?
    
    
    
}
