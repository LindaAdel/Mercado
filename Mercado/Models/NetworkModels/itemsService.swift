//
//  networkModel.swift
//  Mercado
//
//  Created by Linda adel on 5/18/21.
//

import Foundation
import Alamofire
import Firebase


class itemsService{
    
    
    func fetchItemsData<T:Codable>(of:T.Type,url:String,completion : @escaping (T?, Error?)->()){

        AF.request(url)
                .validate()
            .responseDecodable(of: T.self) { (response) in
                    switch response.result {
                    case .success( _):
                       if let items = response.value {
                        completion(items,nil)

                       }

                    case .failure(let error):
                        print(error)
                        completion(nil , error)
        
        
                    }
                }
    }

}
