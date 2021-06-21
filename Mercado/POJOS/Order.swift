//
//  Order.swift
//  Mercado
//
//  Created by Dina ElShabassy on 6/12/21.
//

import Foundation

class Order : Codable{
    var items : [CartItem]?
    var shippingAddress : String?
    var totalPrice : Float?
    var timeStamp : Int?
    var orderNumber : String?
    
    internal init(items: [CartItem]? = nil, shippingAddress: String? = nil, totalPrice: Float? = nil) {
           self.items = items
           self.shippingAddress = shippingAddress
           self.totalPrice = totalPrice
       }
    
}



