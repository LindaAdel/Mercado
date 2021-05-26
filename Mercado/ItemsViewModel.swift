//
//  homeAppliancesViewModel.swift
//  Mercado
//
//  Created by Linda adel on 5/18/21.
//

import Foundation
class my<T>
{
    var myArray : [T]!
 
    func myFunc()  {
        //self.myArray = arr
        print(myArray)
    }
    var bindhomeAppliancesViewModelToView: (([T])->()) = {_ in }

}

class ItemsViewModel: NSObject
{
    var subCategoryObj : SubCategory!
//    var itemArray : [ItemProtocol]!
  //  var c :my<>!
//    func my<T>(of:T.Type,arr:T)
//    {
//    let myArray : T = arr
//      //  self.itemArray = myArray
//        print("myarraaay\(type(of: myArray)) ")
//        print(myArray)
//    }

    var itemService:itemsService!

    var showError : String! {
        
        didSet{
            
            self.bindViewModelErrorToView()
        }
        
    }
    

   
    var bindViewModelErrorToView : (()->()) = {}
    var bindItemsToView: (([ItemProtocol])->()) = {_ in }

    
    init(subCategoryObj : SubCategory) {
        super.init()
       // self.itemsData = []
        self.itemService = itemsService()
        self.subCategoryObj = subCategoryObj
       
    }

    
    func fetchItemsDataFromAPI()  {
        print("detch\(subCategoryObj.subcategoryName)")
        switch subCategoryObj.subcategoryName {
        case "Beauty Equipment","Hair Stylers":
            itemService.fetchItemsData(of: [PersonalCare].self, url: subCategoryObj.subcategoryAPI){ [self]
                (items,error) in
                self.bindItemsToView(items!)
                
            }
//          itemArray = [PersonalCare]()
        case "Microwaves","Blenders and Mixers":
            print("")
            itemService.fetchItemsData(of: [HomeAppliances].self, url: subCategoryObj.subcategoryAPI){ [self]
                (items,error) in
                self.bindItemsToView(items!)
                
            }
        case "Girl's Clothing","Boy's Clothing":
            itemService.fetchItemsData(of: [KidsClothing].self, url: subCategoryObj.subcategoryAPI){ [self]
                (items,error) in
                self.bindItemsToView(items!)
                
            }
        case "Boy's Shoes","Girl's Shoes":
            itemService.fetchItemsData(of: [KidsShoes].self, url: subCategoryObj.subcategoryAPI){ [self]
                (items,error) in
                self.bindItemsToView(items!)
                
            }
        case "Women's Clothing":
            itemService.fetchItemsData(of: [WomenClothing].self, url: subCategoryObj.subcategoryAPI){ [self]
                (items,error) in
                self.bindItemsToView(items!)
                
            }
        case "Women's Bags":
            itemService.fetchItemsData(of: [WomenBags].self, url: subCategoryObj.subcategoryAPI){ [self]
                (items,error) in
                self.bindItemsToView(items!)
            }
        case "Makeup":
            itemService.fetchItemsData(of: [MakeUp].self, url: subCategoryObj.subcategoryAPI){ [self]
                (items,error) in
                self.bindItemsToView(items!)
                
            }
        case "Skincare":
            itemService.fetchItemsData(of: [SkinCare].self, url: subCategoryObj.subcategoryAPI){ [self]
                (items,error) in
                self.bindItemsToView(items!)
                
            }
        case "Laptops":
            itemService.fetchItemsData(of: [Laptops].self, url: subCategoryObj.subcategoryAPI){ [self]
                (items,error) in
                self.bindItemsToView(items!)
                
            }
        case "Laptop Bags":
            itemService.fetchItemsData(of: [LaptopBags].self, url: subCategoryObj.subcategoryAPI){ [self]
                (items,error) in
                self.bindItemsToView(items!)
                
            }
        case "Mobiles","Tablets":
            itemService.fetchItemsData(of: [TabletsAndMobiles].self, url: subCategoryObj.subcategoryAPI){ [self]
                (items,error) in
                self.bindItemsToView(items!)
            }

       
        default:
            print("no sub category found")
        }
//    func fetchItemsDataFromAPI (){
//        
//        itemService.fetchItemsData(completion: { (itemsData, error) in
//            
//            if let error : Error = error{
//                
//                let message = error.localizedDescription
//                print(message)
//                self.showError = message
//                
//            }else{
//                
//                self.itemsData = itemsData
//                
//            }
//           
//        })
//    }
}
}
