//
//  itemsTableViewController.swift
//  Mercado
//
//  Created by Linda adel on 5/17/21.
//

import UIKit


class itemsTableViewController: UIViewController {
    
    var subCategoryObj = SubCategory(subcategoryAPI: "", subcategoryName: "" ,itemSubCategoryName: "" )
  
    var categoryName : String?
    var itemcategoryName : String?
    var itemIsFavoriteArr : [ItemIsFavorite?]!
    var searchingItem = [ItemProtocol]()
    var isSearching : Bool = false
    var favoriteItem = Favorite()
    var itemsList: [ItemProtocol]!
    var itemsViewModel : ItemsViewModel!
    var itemService : itemsService!
 
    
    
    @IBOutlet weak var itemsSearchBar: UISearchBar!
    @IBOutlet weak var itemsTableView: UITableView!
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
  
        itemsTableView.delegate = self
        itemsTableView.dataSource = self
        
        itemsViewModel = ItemsViewModel(subCategoryObj: self.subCategoryObj)
        itemsList = [ItemProtocol]()
        itemService = itemsService()
       
        itemsViewModel.fetchItemsDataFromAPI()
       
       
        

        itemsViewModel.bindItemsToView = {
               (items) in
           self.itemsList = items
            self.itemIsFavoriteArr = [ItemIsFavorite?](repeating: nil, count: items.count)
           self.itemsTableView.reloadData()
            for i in 0...items.count-1 {
                self.itemsViewModel.itemIsFavoriteValue(itemIdValue: items[i].item_id!, index: i)
        
            }
    }
        self.itemsViewModel.bindItemFavoriteToView = {
            (isFav,index) in
        self.itemIsFavoriteArr[index] = ItemIsFavorite(isFavorite: isFav)
          print(index , isFav)
            DispatchQueue.main.async {
                self.itemsTableView.reloadData()
            }
            
          
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



