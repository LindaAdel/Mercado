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
    
    var itemsList: [ItemProtocol] = []
    var itemsViewModel : ItemsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        itemsTableView.delegate = self
        itemsTableView.dataSource = self
        itemsViewModel = ItemsViewModel(subCategoryObj: self.subCategoryObj)
        
//        print("items view category name = \(categoryName!)")
//        print("items view subCategory =\(subCategoryObj.subcategoryName)")
        itemsViewModel.fetchItemsDataFromAPI()
//        itemsService().fetchItemsData(of: [personalCare].self,url:subCategoryObj.subcategoryAPI)
//        itemsViewModel = homeAppliancesViewModel()
      //  checkName()
        

        itemsViewModel.bindItemsToView = {
                    (items) in
            self.itemsList = items
            self.itemsTableView.reloadData()
          //  print("reloaded")
          //  print(self.itemsList.count)
            
       
       
    }
    
    
       
        itemsViewModel.bindViewModelErrorToView = {
        
            self.onFailUpdateView()
        }
    }
  
        
        func onFailUpdateView(){
            let alert = UIAlertController(title: "Error", message: itemsViewModel.showError, preferredStyle: .alert)

            let okAction  = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in


            }
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)

 }
    
}


