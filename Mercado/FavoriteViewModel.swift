//
//  favoriteViewModel.swift
//  Mercado
//
//  Created by Linda adel on 5/25/21.
//

import Foundation
import Firebase

class FavoriteViewModel : NSObject {
    
    var favoriteService : FavoriteService!
    var favArray : [SpecialItem]?
    var firebaseManager : FirebaseManager!
    var ref : DatabaseReference! = Database.database().reference()
    
    var showError : String! {
        
        didSet{
            
            self.bindViewModelErrorToView()
        }
        
    }
    var bindViewModelErrorToView : (()->()) = {}
    var bindItemsToView: ((SpecialItem?,ItemProtocol?)->()) = {_,_  in }
    
    override init() {
        super.init()
        favoriteService = FavoriteService()
        firebaseManager = FirebaseManager.shared
    }
    func fetchFavorite(){
        favoriteService.fetchArrayOfSpecialItems(completion: {(favoriteArray ,error)  in
            if let error : Error = error{
                
                let message = error.localizedDescription
                self.showError = message
                
            }else{
                
                self.favArray = favoriteArray
                self.favArray?.forEach{ favItem in
                    self.switchOnFavorite(favItem: favItem)
                }
                
            }
        })
    }
            func switchOnFavorite(favItem : SpecialItem){
                
                switch favItem.subCategory{
                
                case "beautyEquipment","hairStylers":
                    self.firebaseManager.searchForItem(specialItem: favItem) { (items, error) in
                        let decoder = JSONDecoder()
                        let item = items as! Dictionary <String, Any>
                        var data : PersonalCare!
                        do{
                            data = try decoder.decode(PersonalCare.self, from: JSONSerialization.data(withJSONObject: item))
                        }catch{
                            print(error)
                        }
                        
                        self.bindItemsToView(favItem,data!)
                        
                        
                        
                    }
                    
                case "microwaves","blendersAndMixers":
                    self.firebaseManager.searchForItem(specialItem: favItem) { (items, error) in
                        let decoder = JSONDecoder()
                        //let item = decoder.decode(PersonalCare.self, from: items as Data)
                        let item = items as! Dictionary <String, Any>
                        var data : HomeAppliances!
                        do{
                            data = try decoder.decode(HomeAppliances.self, from: JSONSerialization.data(withJSONObject: item))
                        }catch{
                            print(error)
                        }
                        
                        self.bindItemsToView(favItem,data!)
                        
                        
                        
                    }
                case "clothing":
                    if favItem.category == "Girl's Fashion" || favItem.category == "boy's fashion"{
                        self.firebaseManager.searchForItem(specialItem: favItem) { (items, error) in
                            let decoder = JSONDecoder()
                            let item = items as! Dictionary <String, Any>
                            var data : KidsClothing!
                            do{
                                data = try decoder.decode(KidsClothing.self, from: JSONSerialization.data(withJSONObject: item))
                            }catch{
                                print(error)
                            }
                            
                            self.bindItemsToView(favItem,data!)
                            
                            
                        }
                    }
                    if  favItem.category ==  "Women's Fashion"{
                        self.firebaseManager.searchForItem(specialItem: favItem) { (items, error) in
                            let decoder = JSONDecoder()
                            let item = items as! Dictionary <String, Any>
                            var data : WomenClothing!
                            do{
                                data = try decoder.decode(WomenClothing.self, from: JSONSerialization.data(withJSONObject: item))
                            }catch{
                                print(error)
                            }
                            self.bindItemsToView(favItem,data!)
                            
                            
                        }
                    }
                case "shoes":
                    if  favItem.category == "Girl's Fashion" || favItem.category ==  "boy's fashion"{
                        self.firebaseManager.searchForItem(specialItem: favItem) { (items, error) in
                            let decoder = JSONDecoder()
                            let item = items as! Dictionary <String, Any>
                            var data : KidsShoes!
                            do{
                                data = try decoder.decode(KidsShoes.self, from: JSONSerialization.data(withJSONObject: item))
                            }catch{
                                print(error)
                            }
                            self.bindItemsToView(favItem,data!)
                            
                        }
                    }
                case "bags":
                    self.firebaseManager.searchForItem(specialItem: favItem) { (items, error) in
                        let decoder = JSONDecoder()
                        let item = items as! Dictionary <String, Any>
                        var data : WomenBags!
                        do{
                            data = try decoder.decode(WomenBags.self, from: JSONSerialization.data(withJSONObject: item))
                        }catch{
                            print(error)
                        }
                        self.bindItemsToView(favItem,data!)
                        
                    }
                case "makeUp":
                    self.firebaseManager.searchForItem(specialItem: favItem) { (items, error) in
                        let decoder = JSONDecoder()
                        let item = items as! Dictionary <String, Any>
                        var data : MakeUp!
                        do{
                            data = try decoder.decode(MakeUp.self, from: JSONSerialization.data(withJSONObject: item))
                        }catch{
                            print(error)
                        }
                        self.bindItemsToView(favItem,data!)
                        
                    }
                case "skinCare":
                    self.firebaseManager.searchForItem(specialItem: favItem) { (items, error) in
                        let decoder = JSONDecoder()
                        let item = items as! Dictionary <String, Any>
                        var data : SkinCare!
                        do{
                            data = try decoder.decode(SkinCare.self, from: JSONSerialization.data(withJSONObject: item))
                        }catch{
                            print(error)
                        }
                        self.bindItemsToView(favItem,data!)
                        
                    }
                case "laptops":
                    self.firebaseManager.searchForItem(specialItem: favItem) { (items, error) in
                        let decoder = JSONDecoder()
                        let item = items as! Dictionary <String, Any>
                        var data : Laptops!
                        do{
                            data = try decoder.decode(Laptops.self, from: JSONSerialization.data(withJSONObject: item))
                        }catch{
                            print(error)
                        }
                        self.bindItemsToView(favItem,data!)
                        
                        
                    }
                case "laptopBags":
                    self.firebaseManager.searchForItem(specialItem: favItem) { (items, error) in
                        let decoder = JSONDecoder()
                        let item = items as! Dictionary <String, Any>
                        var data : LaptopBags!
                        do{
                            data = try decoder.decode(LaptopBags.self, from: JSONSerialization.data(withJSONObject: item))
                        }catch{
                            print(error)
                        }
                        self.bindItemsToView(favItem,data!)
                        
                    }
                case "mobiles","tablets":
                    self.firebaseManager.searchForItem(specialItem: favItem) { (items, error) in
                        let decoder = JSONDecoder()
                        let item = items as! Dictionary <String, Any>
                        var data : TabletsAndMobiles!
                        do{
                            data = try decoder.decode(TabletsAndMobiles.self, from: JSONSerialization.data(withJSONObject: item))
                        }catch{
                            print(error)
                        }
                        self.bindItemsToView(favItem,data!)
                        
                    }
                    
                default:
                    print("no sub category found")
                }
                
                
            }
            
    
}





