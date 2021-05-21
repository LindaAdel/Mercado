//
//  tabletsPojo.swift
//  Mercado
//
//  Created by Linda adel on 5/17/21.
//

import Foundation
import UIKit

class TabletsAndMobiles : ItemProtocol,Codable {
   // var type: String?// to conform
    
    
    var item_image: String?
    var item_price :String?
    var item_title : String?
    var item_id: String?
    var color : String?
    var brand : String?
    var memory : String?
    var model : String?
    var processor : String?
    var front_camera : String?
    var connectivity : String?
    var rear_camera : String?
    var display : String?
    var battery_capacity : String?
    var slider_images :[String]?
    
    
    
//    enum CodingKeys: String, CodingKey {
//
//                   case
//                        item_price ,
//                        item_image,
//                        item_title,
//                        item_id,
//                        color,
//                        brand,
//                        memory,
//                        model,
//                        processor ,
//                        front_camera ,
//                        connectivity,
//                        rear_camera,
//                        display ,
//                        battery_capacity,
//                        slider_images
//    }
    
}
