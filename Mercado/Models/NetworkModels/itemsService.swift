//
//  networkModel.swift
//  Mercado
//
//  Created by Linda adel on 5/18/21.
//

import Foundation
import Alamofire

//class mySt{
// //   var s = itemsService<personalCare.self>()
//    itemsService().f
//}
class itemsService{
    
//    var pojoClass  = mySt<personalCare.Type>
//    var subCategoryAPI : String = ""
    
    func fetchItemsData<T:Codable>(of:T.Type,url:String,completion : @escaping (T?, Error?)->()){
   //     var items : [personalCare] = []
//        var items : [T]?
        AF.request(url)
                .validate()
            .responseDecodable(of: T.self) { (response) in
                    switch response.result {
                    case .success( _):
                       if let items = response.value {
                        print("fetched")
//                        items = homeAppliancesData as? [T]
//                        print(type(of: homeAppliancesData))
//                        print(type(of: homeAppliancesData))
                        completion(items,nil)

                       }

                    
                    case .failure(let error):
                        print("error")
                print(error)
                        completion(nil , error)
        
        
                    }
                }
    }
}
