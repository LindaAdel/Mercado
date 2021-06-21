//
//  ProductDetailsViewModel.swift
//  Mercado
//
//  Created by Dina ElShabassy on 6/16/21.
//

import Foundation

class ProductDetailsViewModel : NSObject{
    
     var firebaseManager : FirebaseManager!
     
     var bindViewModelErrorToView : (()->()) = {}
     var bindItemFavoriteToView : ((Bool)->()) = {_ in}
     
     var showError : String! {
         
         didSet{
             
             self.bindViewModelErrorToView()
         }
         
     }
     
     override init() {
         self.firebaseManager = FirebaseManager.shared
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
