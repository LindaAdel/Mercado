//
//  CategoriesViewModel.swift
//  Mercado
//
//  Created by Dina ElShabassy on 5/18/21.
//

import Foundation

class CategoriesViewModel : NSObject{
    
    var categoriesService : CategoriesService!
    
    var categoryData :[Categories]! {
        didSet{
            
            self.bindCategoriesViewModelToView()
        }
        
    }
    
    
    var showError : String! {
        
        didSet{
            
            self.bindViewModelErrorToView()
        }
        
    }
    
    
    var bindCategoriesViewModelToView : (()->()) = {}
    var bindViewModelErrorToView : (()->()) = {}
    
    override init() {
        
        super .init()
        self.categoriesService = CategoriesService()
    }
    
    
    func fetchCategoryDataFromAPI (){
        
        categoriesService.fetchCategoriesData { (category, error) in
            
            if let error : Error = error{
            
                let message = error.localizedDescription
                self.showError = message
            }
            else{
                self.categoryData = category
            }
           
    
        }
    }
    
}
