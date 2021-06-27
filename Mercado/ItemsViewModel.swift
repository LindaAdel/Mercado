//
//  homeAppliancesViewModel.swift
//  Mercado
//
//  Created by Linda adel on 5/18/21.
//

import Foundation
import Firebase

class ItemsViewModel: NSObject
{
    var subCategoryObj : SubCategory!
    var categoryName : String!
    var itemService:itemsService!
    var firebaseManager : FirebaseManager!
   


    var showError : String! {
        
        didSet{
            
            self.bindViewModelErrorToView()
        }
        
    }
    
    var bindViewModelErrorToView : (()->()) = {}
    var bindItemFavoriteToView : ((Bool,Int)->()) = {_,_ in}
    var bindItemsToView: (([ItemProtocol])->()) = {_ in }
    

    
    init(subCategoryObj : SubCategory, categoryName: String) {
        super.init()
        
        self.itemService = itemsService()
        self.firebaseManager = FirebaseManager.shared
        self.subCategoryObj = subCategoryObj
        self.categoryName = categoryName

    }

       func fetchItemsDataFromAPI()  {
    
        
        switch subCategoryObj.itemSubCategoryName {
            case "beautyEquipment","hairStylers":
                itemService.fetchItemsData(of: [PersonalCare].self, url: subCategoryObj.subcategoryAPI){ [self]
                    (items,error) in
                    self.bindItemsToView(items!)
    
                }
    
            case "microwaves","blendersAndMixers":
                itemService.fetchItemsData(of: [HomeAppliances].self, url: subCategoryObj.subcategoryAPI){ [self]
                    (items,error) in
                    self.bindItemsToView(items!)
    
                }
            case "clothing":
                switch categoryName {
                    case "Girl's Fashion","boy's fashion":
                        itemService.fetchItemsData(of: [KidsClothing].self, url: subCategoryObj.subcategoryAPI){ [self]
                            (items,error) in
                            self.bindItemsToView(items!)
            
                        }
                    case "Women's Fashion":
                        itemService.fetchItemsData(of: [WomenClothing].self, url: subCategoryObj.subcategoryAPI){ [self]
                                    (items,error) in
                            self.bindItemsToView(items!)
                    
                        }
                    default:
                        print("no kids")
            }

            case "shoes":
                switch categoryName {
                    case "Girl's Fashion","boy's fashion":
                        itemService.fetchItemsData(of: [KidsShoes].self, url: subCategoryObj.subcategoryAPI){ [self]
                            (items,error) in
                            self.bindItemsToView(items!)
            
                        }
                    default:
                        print("no shoes")
            }
            
            case "bags":
                itemService.fetchItemsData(of: [WomenBags].self, url: subCategoryObj.subcategoryAPI){ [self]
                    (items,error) in
                    self.bindItemsToView(items!)
                }
            case "makeUp":
                itemService.fetchItemsData(of: [MakeUp].self, url: subCategoryObj.subcategoryAPI){ [self]
                    (items,error) in
                    self.bindItemsToView(items!)
    
                }
            case "skinCare":
                itemService.fetchItemsData(of: [SkinCare].self, url: subCategoryObj.subcategoryAPI){ [self]
                    (items,error) in
                    self.bindItemsToView(items!)
    
                }
            case "laptops":
                itemService.fetchItemsData(of: [Laptops].self, url: subCategoryObj.subcategoryAPI){ [self]
                    (items,error) in
                    self.bindItemsToView(items!)
    
                }
            case "laptopBags":
                itemService.fetchItemsData(of: [LaptopBags].self, url: subCategoryObj.subcategoryAPI){ [self]
                    (items,error) in
                    self.bindItemsToView(items!)
    
                }
            case "mobiles","tablets":
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



