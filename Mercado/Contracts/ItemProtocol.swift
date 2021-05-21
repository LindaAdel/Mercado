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
    @objc optional var texture : String?{get}
    @objc optional var item_features : String?{get}
    @objc optional var model_number : String?{get}
    @objc optional  var material : String?{get}
    @objc optional  var color : String? {get}
    @objc optional var type : String? {get}
    @objc optional var size : String?{get}
}
