//
//  homeAppliancesViewModel.swift
//  Mercado
//
//  Created by Linda adel on 5/18/21.
//

import Foundation
import Firebase



class my<T>
{
    var myArray : [T]!
 
    func myFunc()  {
        
        //print(myArray)
    }
    var bindhomeAppliancesViewModelToView: (([T])->()) = {_ in }

}


class ItemsViewModel: NSObject
{
    var subCategoryObj : SubCategory!
    var itemService:itemsService!
    var firebaseManager : DinaFirebaseManager!
   


    var showError : String! {
        
        didSet{
            
            self.bindViewModelErrorToView()
        }
        
    }
    
    var bindViewModelErrorToView : (()->()) = {}
    var bindItemFavoriteToView : ((Bool,Int)->()) = {_,_ in}
    var bindItemsToView: (([ItemProtocol])->()) = {_ in }
    

    
    init(subCategoryObj : SubCategory) {
        super.init()
        
        self.itemService = itemsService()
        self.firebaseManager = DinaFirebaseManager()
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

        case "Microwaves","Blenders and Mixers":
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
        
    }
    
    func itemIsFavoriteValue(itemIdValue : String , index : Int){
        firebaseManager.fetchItemIsFavoriteData(itemId: itemIdValue) { (isFav, error) in
            if let error : Error = error{
                
                let message = error.localizedDescription
                self.showError = message
                
            }else{
                self.bindItemFavoriteToView(isFav,index)
            }
        }
    }
  
}



