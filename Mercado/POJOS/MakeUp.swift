//
//  makeUpPojo.swift
//  Mercado
//
//  Created by Linda adel on 5/17/21.
//

import Foundation
import  UIKit

class MakeUp :ItemProtocol , Codable{
//    var type: String? // to conform
    
    
    var item_image: String?
    var item_price :String?
    var item_rating :String?
    var item_title : String?
    var item_id: String?
    var brand : String?
    var item_description : String?
    var color : String?
    var slider_images :[String]?
    var weight : String?
    var dimensions : String?
    
//    enum CodingKeys: String, CodingKey {
//
//           case item_rating,item_title, item_image, item_price,
//                brand,slider_images,item_id,item_description,dimensions
//        ,weight,color
//    }
}
