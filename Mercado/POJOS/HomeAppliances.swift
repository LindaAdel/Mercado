//
//  homeAppliancesPojo.swift
//  Mercado
//
//  Created by Linda adel on 5/17/21.
//

import Foundation
protocol ItemProtocol {
    var item_title : String? {get}
    var item_image: String?{get}
    var item_price : String?{get}
}
//class mode{
//    var arr:[ItemProtocol]
//    arr = [HomeAppliances]
//    print(arr.item_title)
//}

struct HomeAppliances :Codable,ItemProtocol{
    var color : String?
    var country : String?
    var item_Features : String?
    var item_brand : String?
    var item_capacity :String?
    var item_title : String?
    var item_image: String?
    var item_price : String?
    var item_type :String?
    var model_number : String?
    var power :String?
    var slider_images :[String?]
    var item_id: String?
}
