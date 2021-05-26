//
//  itemsTableViewController.swift
//  Mercado
//
//  Created by Linda adel on 5/17/21.
//

import UIKit


class itemsTableViewController: UIViewController {
    
    var subCategoryObj = SubCategory(subcategoryAPI: "", subcategoryName: "" ,itemSubCategoryName: "" )
  //  var CategoryObj =
    var categoryName : String?
    var itemcategoryName : String?
    //var item_id : String?
    var searchingItem = [ItemProtocol]()
    var isSearching : Bool = false
    var favoriteItem = Favorite()
    
    var itemIsFavorite : Bool = false
    
    
    @IBOutlet weak var itemsSearchBar: UISearchBar!
    @IBOutlet weak var itemsTableView: UITableView!
    
    var itemsList: [ItemProtocol]!
    var itemsViewModel : ItemsViewModel!
    var itemService : itemsService!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
     //   print(itemcategoryName)
        
        itemsTableView.delegate = self
        itemsTableView.dataSource = self
        
        itemsViewModel = ItemsViewModel(subCategoryObj: self.subCategoryObj)
        itemsList = [ItemProtocol]()
        itemService = itemsService()
        itemsViewModel.fetchItemsDataFromAPI()
       
        

        itemsViewModel.bindItemsToView = {
               (items) in
           self.itemsList = items
           self.itemsTableView.reloadData()

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



