//
//  ItemProtocol.swift
//  Mercado
//
//  Created by Mayar Adel on 5/21/21.
//

import Foundation
@objc protocol ItemProtocol {
    var item_title : String? {get}
    var item_image: String?{get}
    var item_price : String?{get}
    var slider_images :[String]? {get}
    var item_id: String? {get}
    var brand : String? {get}
    @objc optional var item_description : String?{get}
    @objc optional var price_afterSale : String?{get}
    @objc optional var texture : String?{get}
    @objc optional var item_features : String?{get}
    @objc optional var model_number : String?{get}
    @objc optional  var material : String?{get}
    @objc optional  var color : String? {get}
    @objc optional var type : String? {get}
    @objc optional var size : String?{get}
    //home appliances
    @objc optional var country : String?{get}
    @objc optional var power :String?{get}
    @objc optional var item_capacity :String?{get}
    
    //mobiles and tablets
    @objc optional var memory : String? {get}
    @objc optional var processor : String?{get}
    @objc optional var front_camera : String?{get}
    @objc optional var connectivity : String?{get}
    @objc optional var battery_capacity : String?{get}
    @objc optional var rear_camera : String?{get}
    
    //laptops
    @objc optional var display_size :String?{get}
    @objc optional var model : String?{get}
    @objc optional var operating_system : String?{get}
    @objc optional var ram : String?{get}
    @objc optional var storage :String?{get}
    
    //laptops bags
    @objc optional var compatible_with : String?{get}
    @objc optional var warranty_years : String?{get}
    @objc optional var water_resistant : String?{get}
}
