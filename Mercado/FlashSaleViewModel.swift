//
//  FlashSaleViewModel.swift
//  Mercado
//
//  Created by Dina ElShabassy on 6/5/21.
//

import Foundation

class FlashSaleViewModel : NSObject{
    
    var flashSaleService : FlashSaleService!
    
    var flashSaleArray :[FlashSale]! {
        didSet{
            
            self.bindFlashSaleViewModelToView()
        }
        
    }
    
    
    var showError : String! {
        
        didSet{
            
            self.bindViewModelErrorToView()
        }
        
    }
    
    
    var bindFlashSaleViewModelToView : (()->()) = {}
    var bindViewModelErrorToView : (()->()) = {}
    
    override init() {
        
        super .init()
        self.flashSaleService = FlashSaleService()
    }
    
    
    func fetchFlashSaleArray (){
        
        flashSaleService.fetchFlashSaleArraycompletion(completion: { (flashSale, error) in
            if let error : Error = error{
            
                let message = error.localizedDescription
                self.showError = message
            }
            else{
                self.flashSaleArray = flashSale
            }
        })
    }
    
}
