//
//  CategoriesService.swift
//  Mercado
//
//  Created by Dina ElShabassy on 5/18/21.
//

import Foundation
import Alamofire

class CategoriesService {
    
    func fetchCategoriesData(completion : @escaping ([Categories]?, Error?)->()){
    
        AF.request(URLs.allCategoriesAPI)
            .validate()
            .responseDecodable(of: [Categories].self) { (response) in
                switch response.result {
                
                case .success( _):
                    
                    guard let categories = response.value else { return }
                    
                    completion(categories,nil)
                    
                case .failure(let error):
                    
                    completion(nil , error)
                    
                    
                }
            }
    }
    
}


