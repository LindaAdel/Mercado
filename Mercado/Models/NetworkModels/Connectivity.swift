//
//  Connectivity.swift
//  Mercado
//
//  Created by Dina ElShabassy on 6/22/21.
//

import Foundation
import Alamofire

class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}
