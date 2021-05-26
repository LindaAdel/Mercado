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
    var favArray : [Favorite]?
    var ref : DatabaseReference! = Database.database().reference()
    
    var showError : String! {
        
        didSet{
            
            self.bindViewModelErrorToView()
        }
        
    }
    var bindViewModelErrorToView : (()->()) = {}
    var bindItemsToView: ((Favorite?,ItemProtocol?)->()) = {_,_  in }
    
    override init() {
        super.init()
        favoriteService = FavoriteService()
    }
    func fetchFavorite(){
       favoriteService.fetchFavoriteData(completion: {(favoriteArray ,error)  in
           if let error : Error = error{
               
               let message = error.localizedDescription
               self.showError = message
               
           }else{
               
               self.favArray = favoriteArray
               self.favArray?.forEach{ favItem in
                   switchOnFavorite(favItem: favItem)
               }
               
           }
   func switchOnFavorite(favItem : Favorite){
               
       switch favItem.subcategoryName{
      
       case "beautyEquipment","hairStylers":
        self.favoriteService.searchForItemData(favoriteItem: favItem) { (items, error) in
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
        self.favoriteService.searchForItemData(favoriteItem: favItem) { (items, error) in
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
       if favItem.categoryName == "Girl's Fashion" || favItem.categoryName == "boy's fashion"{
        self.favoriteService.searchForItemData(favoriteItem: favItem) { (items, error) in
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
       if  favItem.categoryName ==  "Women's Fashion"{
        self.favoriteService.searchForItemData(favoriteItem: favItem) { (items, error) in
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
       if  favItem.categoryName == "Girl's Fashion" || favItem.categoryName ==  "boy's fashion"{
        self.favoriteService.searchForItemData(favoriteItem: favItem) { (items, error) in
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
        self.favoriteService.searchForItemData(favoriteItem: favItem) { (items, error) in
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
        self.favoriteService.searchForItemData(favoriteItem: favItem) { (items, error) in
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
        self.favoriteService.searchForItemData(favoriteItem: favItem) { (items, error) in
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
        self.favoriteService.searchForItemData(favoriteItem: favItem) { (items, error) in
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
        self.favoriteService.searchForItemData(favoriteItem: favItem) { (items, error) in
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
        self.favoriteService.searchForItemData(favoriteItem: favItem) { (items, error) in
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

   })

   }
   }
       
           
       


