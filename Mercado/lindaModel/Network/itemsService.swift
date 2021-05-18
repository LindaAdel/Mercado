//
//  networkModel.swift
//  Mercado
//
//  Created by Linda adel on 5/18/21.
//

import Foundation
import Alamofire

class itemsService{
    
    func fetchItemsData(completion :@escaping ([homeAppliances]?, Error?)->()){
    
    AF.request(URLs.gethomeAppliancesURL)
        .validate()
        .responseDecodable(of: [homeAppliances].self) { (response) in
            switch response.result {
            
            case .success( _):
                
                guard let homeAppliancesData = response.value else { return }
                
                completion(homeAppliancesData,nil)
                
                
            case .failure(let error):
                
                completion(nil , error)
                
                
            }
        }
}
    
}
