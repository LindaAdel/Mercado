//
//  ExclusiveOffersViewModel.swift
//  Mercado
//
//  Created by Dina ElShabassy on 5/26/21.
//

import Foundation

class ExclusiveOffersViewModel : NSObject{
    
    var itemsData = [SpecialItem]()
    var firebaseManager : FirebaseManager!
    var exclusiveOffersService : ExclusiveOffersService!
    
    var bindViewModelErrorToView : (()->()) = {}
    var bindItemFavoriteToView : ((Bool)->()) = {_ in}
    var bindItemsToView: ((SpecialItem?,ItemProtocol?)->()) = {_,_ in }
    
    var showError : String! {
        
        didSet{
            
            self.bindViewModelErrorToView()
        }
        
    }
    
    override init() {
        self.exclusiveOffersService = ExclusiveOffersService()
        self.firebaseManager = FirebaseManager.shared
    }
    
    func fetchAllExclusiveOffersItems (){
    
            exclusiveOffersService.fetchArrayOfSpecialItems(completion: { (itemsData, error) in
           
                if let error : Error = error{
    
                    let message = error.localizedDescription
                    print(message)
                    self.showError = message
    
                }else{
    
                    self.itemsData = itemsData!
                    self.itemsData.forEach{ item in
                        self.itemIsFavoriteValue(itemIdValue: item.itemId!)
                        self.subcategorySwitch(newArrivalItem: item)
                    }
    
                }
    
            })
        }
    
    func subcategorySwitch (newArrivalItem : SpecialItem){
        
        switch newArrivalItem.subCategory {
                case "beautyEquipment","hairStylers":
                    firebaseManager.searchForItem(specialItem: newArrivalItem) { (items, error) in
                        let decoder = JSONDecoder()
                        let item = items as! Dictionary <String, Any>
                        var data : PersonalCare!
                        do{
                            data = try decoder.decode(PersonalCare.self, from: JSONSerialization.data(withJSONObject: item))
                        }catch{
                            print(error)
                        }
                     
                        
                        self.bindItemsToView(newArrivalItem,data)
                        
                    }

                case "microwaves","blendersAndMixers":
                    firebaseManager.searchForItem(specialItem: newArrivalItem) { (items, error) in
                        let decoder = JSONDecoder()
                        let item = items as! Dictionary <String, Any>
                        var data : HomeAppliances!
                        do{
                            data = try decoder.decode(HomeAppliances.self, from: JSONSerialization.data(withJSONObject: item))
                        }catch{
                            print(error)
                        }
                     
                        self.bindItemsToView(newArrivalItem,data)
                        

                    }
                case "clothing":
                    if newArrivalItem.category == "Girl's Fashion" || newArrivalItem.category == "boy's fashion"{
                        firebaseManager.searchForItem(specialItem: newArrivalItem) { (items, error) in
                            let decoder = JSONDecoder()
                            let item = items as! Dictionary <String, Any>
                            var data : KidsClothing!
                            do{
                                data = try decoder.decode(KidsClothing.self, from: JSONSerialization.data(withJSONObject: item))
                            }catch{
                                print(error)
                            }
                         
                            self.bindItemsToView(newArrivalItem,data)
                            
                            }
                        }
                    
                        else if newArrivalItem.category == "Women's Fashion"{
                        firebaseManager.searchForItem(specialItem: newArrivalItem) { (items, error) in
                            let decoder = JSONDecoder()
                            let item = items as! Dictionary <String, Any>
                            var data : WomenClothing!
                            do{
                                data = try decoder.decode(WomenClothing.self, from: JSONSerialization.data(withJSONObject: item))
                            }catch{
                                print(error)
                            }
                      
                            self.bindItemsToView(newArrivalItem,data)

                        }
                    }
                case "shoes":
                        if newArrivalItem.category == "Girl's Fashion" || newArrivalItem.category == "boy's fashion"{
                            firebaseManager.searchForItem(specialItem: newArrivalItem) { (items, error) in
                                let decoder = JSONDecoder()
                                let item = items as! Dictionary <String, Any>
                                var data : KidsClothing!
                                do{
                                    data = try decoder.decode(KidsClothing.self, from: JSONSerialization.data(withJSONObject: item))
                                }catch{
                                    print(error)
                                }
                              
                                self.bindItemsToView(newArrivalItem,data)
                        }
                    }
                case "bags":
                    firebaseManager.searchForItem(specialItem: newArrivalItem) { (items, error) in
                        let decoder = JSONDecoder()
                        let item = items as! Dictionary <String, Any>
                        var data : WomenBags!
                        do{
                            data = try decoder.decode(WomenBags.self, from: JSONSerialization.data(withJSONObject: item))
                        }catch{
                            print(error)
                        }
                      
                        self.bindItemsToView(newArrivalItem,data)

                    }
                case "makeUp":
                    firebaseManager.searchForItem(specialItem: newArrivalItem) { (items, error) in
                        let decoder = JSONDecoder()
                        let item = items as! Dictionary <String, Any>
                        var data : MakeUp!
                        do{
                            data = try decoder.decode(MakeUp.self, from: JSONSerialization.data(withJSONObject: item))
                        }catch{
                            print(error)
                        }
                     
                        self.bindItemsToView(newArrivalItem,data)

                    }
                case "skinCare":
                    firebaseManager.searchForItem(specialItem: newArrivalItem) { (items, error) in
                        let decoder = JSONDecoder()
                        let item = items as! Dictionary <String, Any>
                        var data : SkinCare!
                        do{
                            data = try decoder.decode(SkinCare.self, from: JSONSerialization.data(withJSONObject: item))
                        }catch{
                            print(error)
                        }
                       
                        self.bindItemsToView(newArrivalItem,data)

                    }
                case "laptops":
                    firebaseManager.searchForItem( specialItem: newArrivalItem) { (items, error) in
                        let decoder = JSONDecoder()
                        let item = items as! Dictionary <String, Any>
                        var data : Laptops!
                        do{
                            data = try decoder.decode(Laptops.self, from: JSONSerialization.data(withJSONObject: item))
                        }catch{
                            print(error)
                        }
                    
                        self.bindItemsToView(newArrivalItem,data)

                    }
                case "laptopBags":
                    firebaseManager.searchForItem( specialItem: newArrivalItem) { (items, error) in
                        let decoder = JSONDecoder()
                        let item = items as! Dictionary <String, Any>
                        var data : LaptopBags!
                        do{
                            data = try decoder.decode(LaptopBags.self, from: JSONSerialization.data(withJSONObject: item))
                        }catch{
                            print(error)
                        }
                      
                        self.bindItemsToView(newArrivalItem,data)

                    }
                case "mobiles","tablets":
                    firebaseManager.searchForItem( specialItem: newArrivalItem) { (items, error) in
                        let decoder = JSONDecoder()
                        let item = items as! Dictionary <String, Any>
                        var data : TabletsAndMobiles!
                        do{
                            data = try decoder.decode(TabletsAndMobiles.self, from: JSONSerialization.data(withJSONObject: item))
                        }catch{
                            print(error)
                        }
                       
                        self.bindItemsToView(newArrivalItem,data)

                    }

               
                default:
                    print("no sub category found")
                }
        
    }
    
    func itemIsFavoriteValue(itemIdValue : String ){
        firebaseManager.fetchItemIsFavoriteData(itemId: itemIdValue) { (isFav, error) in
            if let error : Error = error{
                
                let message = error.localizedDescription
                self.showError = message
                
            }else{
                self.bindItemFavoriteToView(isFav)
            }
        }
    }
}
