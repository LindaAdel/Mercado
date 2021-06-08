//
//  CartItem.swift
//  Mercado
//
//  Created by Mayar Adel on 6/1/21.
//

import Foundation
class CartItem :Codable  {
    internal init(category: String? = nil, itemId: String? = nil, subCategory: String? = nil, count: Int? = nil) {
        self.category = category
        self.itemId = itemId
        self.subCategory = subCategory
        self.count = count
    }
    
    var category : String?
    var itemId : String?
    var subCategory : String?
    var count : Int?
}
