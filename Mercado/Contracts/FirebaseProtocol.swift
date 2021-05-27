//
//  FirebaseProtocol.swift
//  Mercado
//
//  Created by Dina ElShabassy on 5/26/21.
//

import Foundation

protocol FirebaseProtocol {
    func fetchArrayOfItems(completion : @escaping ([NewArrival]?, Error?)->())
}
