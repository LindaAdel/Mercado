//
//  OrdersViewModel.swift
//  Mercado
//
//  Created by Dina ElShabassy on 6/12/21.
//

import Foundation

class OrdersViewModel : NSObject{
    
    var ordersService : OrdersService!
    
    var ordersArray :[Order]! {
        didSet{
            
            self.bindOrdersViewModelToView()
        }
        
    }
    
    
    
    var showError : String! {
        
        didSet{
            
            self.bindViewModelErrorToView()
        }
        
    }
    
    
    var bindOrdersViewModelToView : (()->()) = {}
    var bindItemInfoViewModelToView : ((AllItems?)->()) = {_ in }
    var bindViewModelErrorToView : (()->()) = {}
    var bindEmptyOrdersToView : (()->()) = {}
    
    override init() {
        
        super .init()
        self.ordersService = OrdersService()
    }
    
    
    func fetchOrdersArray (){
        
        ordersService.fetchArrayOfOrders(completion: { (ordersArray, error) in
            if let error : Error = error{
            
                let message = error.localizedDescription
                self.showError = message
                
            }
            else if ordersArray != nil{
                self.ordersArray = ordersArray
            }
            else {
                self.bindEmptyOrdersToView()
            }
        })
        
    }
    
    func getItemInfo(itemId : String){
           
        ordersService.searchForItemInAllItems(itemId: itemId, completion: { (allItemsObj, error) in
             if let error : Error = error{
                          
                let message = error.localizedDescription
                self.showError = message
            }
            else{
                self.bindItemInfoViewModelToView(allItemsObj)
            }
        })
       }
    
}
