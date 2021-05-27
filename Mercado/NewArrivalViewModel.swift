//
//  NewArrivalViewModel.swift
//  Mercado
//
//  Created by Dina ElShabassy on 5/25/21.
//

import Foundation

class NewArrivalViewModel : NSObject{
    
    var itemsData = [NewArrival]()
    var newArrivalService : NewArrivalService!
    var firebaseManager : DinaFirebaseManager!
    var exclusiveOffersService : ExclusiveOffersService!
    
    var bindViewModelErrorToView : (()->()) = {}
    var bindItemsToView: ((NewArrival?,ItemProtocol?)->()) = {_,_ in }
   
    
    var showError : String! {
        
        didSet{
            
            self.bindViewModelErrorToView()
        }
        
    }
    
    override init() {
        self.newArrivalService = NewArrivalService()
        self.exclusiveOffersService = ExclusiveOffersService()
        self.firebaseManager = DinaFirebaseManager()
    }
    
        func fetchAllNewArrivalItems (){
    
            newArrivalService.fetchArrayOfItems(completion: { (itemsData, error) in
           
                if let error : Error = error{
    
                    let message = error.localizedDescription
                    print(message)
                    self.showError = message
    
                }else{
    
                    self.itemsData = itemsData!
                    self.itemsData.forEach{ item in
                        //print(item.subCategory)
                        self.subcategorySwitch(newArrivalItem: item)
                    }
    
                }
    
            })
        }
    
    func fetchAllExclusiveOffersItems (){
    
            exclusiveOffersService.fetchArrayOfItems(completion: { (itemsData, error) in
           
                if let error : Error = error{
    
                    let message = error.localizedDescription
                    print(message)
                    self.showError = message
    
                }else{
    
                    self.itemsData = itemsData!
                    self.itemsData.forEach{ item in
                        //print(item.subCategory)
                        self.subcategorySwitch(newArrivalItem: item)
                    }
    
                }
    
            })
        }
    
    func subcategorySwitch (newArrivalItem : NewArrival){
        
        switch newArrivalItem.subCategory {
                case "beautyEquipment","hairStylers":
                    firebaseManager.searchForItem(newArrivalItem: newArrivalItem) { (items, error) in
                        let decoder = JSONDecoder()
                        //let item = decoder.decode(PersonalCare.self, from: items as Data)
                        let item = items as! Dictionary <String, Any>
                        var data : PersonalCare!
                        do{
                            data = try decoder.decode(PersonalCare.self, from: JSONSerialization.data(withJSONObject: item))
                        }catch{
                            print(error)
                        }
                        print(data.item_title!)
                        
                        self.bindItemsToView(newArrivalItem,data)
                        
                    }

                case "microwaves","blendersAndMixers":
                    firebaseManager.searchForItem(newArrivalItem: newArrivalItem) { (items, error) in
                        let decoder = JSONDecoder()
                        //let item = decoder.decode(PersonalCare.self, from: items as Data)
                        let item = items as! Dictionary <String, Any>
                        var data : HomeAppliances!
                        do{
                            data = try decoder.decode(HomeAppliances.self, from: JSONSerialization.data(withJSONObject: item))
                        }catch{
                            print(error)
                        }
                        print(data.item_title!)
                        self.bindItemsToView(newArrivalItem,data)
                        

                    }
                case "clothing":
                    if newArrivalItem.category == "Girl's Fashion" || newArrivalItem.category == "boy's fashion"{
                        firebaseManager.searchForItem(newArrivalItem: newArrivalItem) { (items, error) in
                            let decoder = JSONDecoder()
                            //let item = decoder.decode(PersonalCare.self, from: items as Data)
                            let item = items as! Dictionary <String, Any>
                            var data : KidsClothing!
                            do{
                                data = try decoder.decode(KidsClothing.self, from: JSONSerialization.data(withJSONObject: item))
                            }catch{
                                print(error)
                            }
                            print(data.item_title!)
                            self.bindItemsToView(newArrivalItem,data)
                            
                            }
                        }
                    
                        else if newArrivalItem.category == "Women's Fashion"{
                            firebaseManager.searchForItem(newArrivalItem: newArrivalItem) { (items, error) in
                            let decoder = JSONDecoder()
                            //let item = decoder.decode(PersonalCare.self, from: items as Data)
                            let item = items as! Dictionary <String, Any>
                            var data : WomenClothing!
                            do{
                                data = try decoder.decode(WomenClothing.self, from: JSONSerialization.data(withJSONObject: item))
                            }catch{
                                print(error)
                            }
                            print(data.item_title!)
                            self.bindItemsToView(newArrivalItem,data)

                        }
                    }
                case "shoes":
                        if newArrivalItem.category == "Girl's Fashion" || newArrivalItem.category == "boy's fashion"{
                                firebaseManager.searchForItem(newArrivalItem: newArrivalItem) { (items, error) in
                                let decoder = JSONDecoder()
                                //let item = decoder.decode(PersonalCare.self, from: items as Data)
                                let item = items as! Dictionary <String, Any>
                                var data : KidsClothing!
                                do{
                                    data = try decoder.decode(KidsClothing.self, from: JSONSerialization.data(withJSONObject: item))
                                }catch{
                                    print(error)
                                }
                                print(data.item_title!)
                                self.bindItemsToView(newArrivalItem,data)
                        }
                    }
                case "bags":
                    firebaseManager.searchForItem(newArrivalItem: newArrivalItem) { (items, error) in
                        let decoder = JSONDecoder()
                        //let item = decoder.decode(PersonalCare.self, from: items as Data)
                        let item = items as! Dictionary <String, Any>
                        var data : WomenBags!
                        do{
                            data = try decoder.decode(WomenBags.self, from: JSONSerialization.data(withJSONObject: item))
                        }catch{
                            print(error)
                        }
                        print(data.item_title!)
                        self.bindItemsToView(newArrivalItem,data)

                    }
                case "makeUp":
                    firebaseManager.searchForItem(newArrivalItem: newArrivalItem) { (items, error) in
                        let decoder = JSONDecoder()
                        //let item = decoder.decode(PersonalCare.self, from: items as Data)
                        let item = items as! Dictionary <String, Any>
                        var data : MakeUp!
                        do{
                            data = try decoder.decode(MakeUp.self, from: JSONSerialization.data(withJSONObject: item))
                        }catch{
                            print(error)
                        }
                        print(data.item_title!)
                        self.bindItemsToView(newArrivalItem,data)

                    }
                case "skinCare":
                    firebaseManager.searchForItem(newArrivalItem: newArrivalItem) { (items, error) in
                        let decoder = JSONDecoder()
                        //let item = decoder.decode(PersonalCare.self, from: items as Data)
                        let item = items as! Dictionary <String, Any>
                        var data : SkinCare!
                        do{
                            data = try decoder.decode(SkinCare.self, from: JSONSerialization.data(withJSONObject: item))
                        }catch{
                            print(error)
                        }
                        print(data.item_title!)
                        self.bindItemsToView(newArrivalItem,data)

                    }
                case "laptops":
                    firebaseManager.searchForItem( newArrivalItem: newArrivalItem) { (items, error) in
                        let decoder = JSONDecoder()
                        //let item = decoder.decode(PersonalCare.self, from: items as Data)
                        let item = items as! Dictionary <String, Any>
                        var data : Laptops!
                        do{
                            data = try decoder.decode(Laptops.self, from: JSONSerialization.data(withJSONObject: item))
                        }catch{
                            print(error)
                        }
                        print(data.item_title!)
                        self.bindItemsToView(newArrivalItem,data)

                    }
                case "laptopBags":
                    firebaseManager.searchForItem( newArrivalItem: newArrivalItem) { (items, error) in
                        let decoder = JSONDecoder()
                        //let item = decoder.decode(PersonalCare.self, from: items as Data)
                        let item = items as! Dictionary <String, Any>
                        var data : LaptopBags!
                        do{
                            data = try decoder.decode(LaptopBags.self, from: JSONSerialization.data(withJSONObject: item))
                        }catch{
                            print(error)
                        }
                        print(data.item_title!)
                        self.bindItemsToView(newArrivalItem,data)

                    }
                case "mobiles","tablets":
                   firebaseManager.searchForItem( newArrivalItem: newArrivalItem) { (items, error) in
                        let decoder = JSONDecoder()
                        //let item = decoder.decode(PersonalCare.self, from: items as Data)
                        let item = items as! Dictionary <String, Any>
                        var data : TabletsAndMobiles!
                        do{
                            data = try decoder.decode(TabletsAndMobiles.self, from: JSONSerialization.data(withJSONObject: item))
                        }catch{
                            print(error)
                        }
                        print(data.item_title!)
                        self.bindItemsToView(newArrivalItem,data)

                    }

               
                default:
                    print("no sub category found")
                }
        
    }
}
