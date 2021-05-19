//
//  itemsTableViewController.swift
//  Mercado
//
//  Created by Linda adel on 5/17/21.
//

import UIKit


class itemsTableViewController: UIViewController {

    var subCategoryObj = SubCategory(subcategoryAPI: "", subcategoryName: "")
    var categoryName : String?
    
    @IBOutlet weak var itemsTableView: UITableView!
    
    var itemsList:[homeAppliances] = [homeAppliances]()
    var itemsViewModel : homeAppliancesViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        itemsTableView.delegate = self
        itemsTableView.dataSource = self
        
        print(categoryName!)
        itemsViewModel = homeAppliancesViewModel()
        
        itemsViewModel.bindhomeAppliancesViewModelToView = {
                    
            self.onSuccessUpdateView()
            
    }
       
        itemsViewModel.bindViewModelErrorToView = {
        
            self.onFailUpdateView()
        }
    }
  
   func onSuccessUpdateView(){
            itemsList = itemsViewModel.itemsData
            self.itemsTableView.reloadData()
            
        }
        
        
        func onFailUpdateView(){
            let alert = UIAlertController(title: "Error", message: itemsViewModel.showError, preferredStyle: .alert)
            
            let okAction  = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
                
                
            }
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
 
 }
    
}
