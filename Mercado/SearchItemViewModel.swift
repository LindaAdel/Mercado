//
//  SearchItemViewModel.swift
//  Mercado
//
//  Created by Dina ElShabassy on 6/10/21.
//

import Foundation

class SearchItemViewModel : NSObject{
    
    var allItemsService : AllItemsSearchService!
    var firebaseManager : FirebaseManager!
    
    var filteredItemsArray :[AllItems]! {
        didSet{
            
            self.bindFilteredItemsModelToView()
        }
        
    }
    
    var showError : String! {
        
        didSet{
            
            self.bindViewModelErrorToView()
        }
        
    }
    
    var bindFilteredItemsModelToView : (()->()) = {}
    var bindDetailsItemToView: ((ItemProtocol?)->()) = {_ in }
    var bindViewModelErrorToView : (()->()) = {}
    
    override init() {
        
        super .init()
        self.allItemsService = AllItemsSearchService()
        self.firebaseManager = FirebaseManager.shared
    }
    
    
    func fetchFilteredItemsArray(searchKey : String) {
        
        allItemsService.filterAllItemsArray(searchName: searchKey) { (filteredArray, error) in
             if let error : Error = error{
                       
                let message = error.localizedDescription
                self.showError = message
             }
                else{
                    self.filteredItemsArray = filteredArray
                  }
             }
    }
    
    func getItemDetails (filteredItem : SpecialItem){
        
        switch filteredItem.subCategory {
                case "beautyEquipment","hairStylers":
                    firebaseManager.searchForItem(specialItem: filteredItem) { (items, error) in
                        let decoder = JSONDecoder()
                        let item = items as! Dictionary <String, Any>
                        var data : PersonalCare!
                        do{
                            data = try decoder.decode(PersonalCare.self, from: JSONSerialization.data(withJSONObject: item))
                        }catch{
                           
                        }
                       
                       
                        self.bindDetailsItemToView(data)
                        
                    }

                case "microwaves","blendersAndMixers":
                    firebaseManager.searchForItem(specialItem: filteredItem) { (items, error) in
                        let decoder = JSONDecoder()
                        let item = items as! Dictionary <String, Any>
                        var data : HomeAppliances!
                        do{
                            data = try decoder.decode(HomeAppliances.self, from: JSONSerialization.data(withJSONObject: item))
                        }catch{
                            print(error)
                        }
                        print(data.item_title!)
                        self.bindDetailsItemToView(data)

                    }
                case "clothing":
                    if filteredItem.category == "Girl's Fashion" || filteredItem.category == "boy's fashion"{
                        firebaseManager.searchForItem(specialItem: filteredItem) { (items, error) in
                            let decoder = JSONDecoder()
                            let item = items as! Dictionary <String, Any>
                            var data : KidsClothing!
                            do{
                                data = try decoder.decode(KidsClothing.self, from: JSONSerialization.data(withJSONObject: item))
                            }catch{
                                print(error)
                            }
                          
                            self.bindDetailsItemToView(data)
                            
                            }
                        }
                    
                        else if filteredItem.category == "Women's Fashion"{
                        firebaseManager.searchForItem(specialItem: filteredItem) { (items, error) in
                            let decoder = JSONDecoder()
                            let item = items as! Dictionary <String, Any>
                            var data : WomenClothing!
                            do{
                                data = try decoder.decode(WomenClothing.self, from: JSONSerialization.data(withJSONObject: item))
                            }catch{
                                print(error)
                            }
                         
                            self.bindDetailsItemToView(data)

                        }
                    }
                case "shoes":
                        if filteredItem.category == "Girl's Fashion" || filteredItem.category == "boy's fashion"{
                            firebaseManager.searchForItem(specialItem: filteredItem) { (items, error) in
                                let decoder = JSONDecoder()
                                let item = items as! Dictionary <String, Any>
                                var data : KidsClothing!
                                do{
                                    data = try decoder.decode(KidsClothing.self, from: JSONSerialization.data(withJSONObject: item))
                                }catch{
                                    print(error)
                                }
                             
                                self.bindDetailsItemToView(data)
                        }
                    }
                case "bags":
                    firebaseManager.searchForItem(specialItem: filteredItem) { (items, error) in
                        let decoder = JSONDecoder()
                        let item = items as! Dictionary <String, Any>
                        var data : WomenBags!
                        do{
                            data = try decoder.decode(WomenBags.self, from: JSONSerialization.data(withJSONObject: item))
                        }catch{
                            print(error)
                        }
                     
                        self.bindDetailsItemToView(data)

                    }
                case "makeUp":
                    firebaseManager.searchForItem(specialItem: filteredItem) { (items, error) in
                        let decoder = JSONDecoder()
                        let item = items as! Dictionary <String, Any>
                        var data : MakeUp!
                        do{
                            data = try decoder.decode(MakeUp.self, from: JSONSerialization.data(withJSONObject: item))
                        }catch{
                            print(error)
                        }
                        
                        self.bindDetailsItemToView(data)

                    }
                case "skinCare":
                    firebaseManager.searchForItem(specialItem: filteredItem) { (items, error) in
                        let decoder = JSONDecoder()
                        let item = items as! Dictionary <String, Any>
                        var data : SkinCare!
                        do{
                            data = try decoder.decode(SkinCare.self, from: JSONSerialization.data(withJSONObject: item))
                        }catch{
                            print(error)
                        }
                       
                        self.bindDetailsItemToView(data)

                    }
                case "laptops":
                    firebaseManager.searchForItem( specialItem: filteredItem) { (items, error) in
                        let decoder = JSONDecoder()
                        let item = items as! Dictionary <String, Any>
                        var data : Laptops!
                        do{
                            data = try decoder.decode(Laptops.self, from: JSONSerialization.data(withJSONObject: item))
                        }catch{
                            print(error)
                        }
                      
                        self.bindDetailsItemToView(data)

                    }
                case "laptopBags":
                    firebaseManager.searchForItem( specialItem: filteredItem) { (items, error) in
                        let decoder = JSONDecoder()
                        let item = items as! Dictionary <String, Any>
                        var data : LaptopBags!
                        do{
                            data = try decoder.decode(LaptopBags.self, from: JSONSerialization.data(withJSONObject: item))
                        }catch{
                            print(error)
                        }
                     
                        self.bindDetailsItemToView(data)

                    }
                case "mobiles","tablets":
                    firebaseManager.searchForItem( specialItem: filteredItem) { (items, error) in
                        let decoder = JSONDecoder()
                        let item = items as! Dictionary <String, Any>
                        var data : TabletsAndMobiles!
                        do{
                            data = try decoder.decode(TabletsAndMobiles.self, from: JSONSerialization.data(withJSONObject: item))
                        }catch{
                            print(error)
                        }
                       
                        self.bindDetailsItemToView(data)

                    }

               
                default:
                    print("no sub category found")
                }
        
    }
    
}
