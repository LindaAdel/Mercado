//
//  networkModel.swift
//  Mercado
//
//  Created by Linda adel on 5/18/21.
//

import Foundation
import Alamofire

class itemsService{
    
    var pojoClass : [Codable?] = []
    var subCategoryAPI : String = ""
    
    func fetchItemsData(completion :@escaping ([homeAppliances]?, Error?)->()){
        
        AF.request(testURLs.gethomeAppliancesURL)
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
//
//        AF.request(subCategoryAPI, method: .get, encoding: JSONEncoding.default)
//        .responseJSON { response in
//
//        Alamo.request(subCategoryAPI,
//                              method: .get,
//                              encoder: JSONParameterEncoder.default,
//                              headers: nil).response{(response) in
//
//                               switch response.result {
//
//                               case .success( _):
//
//                                   guard let homeAppliancesData = response.value else { return }
//
//                                   completion(homeAppliancesData,nil)
//
//
//                               case .failure(let error):
//
//                                   completion(nil , error)
//
//
//                               }
//
//
//                                           }
//
//    AF.request(testURLs.gethomeAppliancesURL)
//        .validate()
//        .responseDecodable(of: [Codable].self) { (response) in
//            switch response.result {
//
//            case .success( _):
//
//                guard let homeAppliancesData = response.value else { return }
//
//                completion(homeAppliancesData,nil)
//
//
//            case .failure(let error):
//
//                completion(nil , error)
//
//
//            }
//        }
 //   }
    
//
//    func getSelectedCategory(subCategoryObject : SubCategory , categoryName : String) -> Codable{
//        switch subCategoryObject.subcategoryName {
//        case "Beauty Equipment":
//            fetchItemsData(subCategoryAPI: subCategoryObject.subcategoryAPI, pojo: [personalCare?], completion: nil)
//
//            break
//
//        default:
//            <#code#>
//        }
//        return pojoClass
//    }
    
//}
