//
//  homeAppliancesViewModel.swift
//  Mercado
//
//  Created by Linda adel on 5/18/21.
//

import Foundation

class homeAppliancesViewModel: NSObject {
    var itemService:itemsService!
    var itemsData:[homeAppliances]! {
        didSet{
            self.bindhomeAppliancesViewModelToView()
        }
    }
    
    
    var showError : String! {
        
        didSet{
            
            self.bindViewModelErrorToView()
        }
        
    }
    
    
    var bindhomeAppliancesViewModelToView: (()->()) = {}
    var bindViewModelErrorToView : (()->()) = {}
    
    
    override init() {
        super.init()
        self.itemService = itemsService()
        self.fetchItemsDataFromAPI()
       
    }
    
    
    func fetchItemsDataFromAPI (){
        
        itemService.fetchItemsData(completion: { (itemsData, error) in
            
            if let error : Error = error{
                
                let message = error.localizedDescription
                print(message)
                self.showError = message
                
            }else{
                
                self.itemsData = itemsData
                
            }
           
        })
    }
}
