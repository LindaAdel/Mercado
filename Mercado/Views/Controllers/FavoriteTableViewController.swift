//
//  FavoriteTableViewController.swift
//  Mercado
//
//  Created by Linda adel on 5/22/21.
//

import UIKit

class FavoriteTableViewController: UIViewController {
    var subCategoryObj = SubCategory(subcategoryAPI: "", subcategoryName: ""
        , itemSubCategoryName: "")
    var categoryName : String?
    var favoriteItemInfoArr : [Favorite]!
    var itemId : String?
    var subCategoryName : String?
    var favoriteList : [ItemProtocol]!
    var favoriteViewModel : FavoriteViewModel!
    
 
    @IBOutlet weak var FavoriteTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        FavoriteTableView.delegate = self
        FavoriteTableView.dataSource = self
        
        favoriteViewModel = FavoriteViewModel()
        favoriteList = [ItemProtocol]()
        favoriteItemInfoArr = [Favorite]()
        
        favoriteViewModel.bindItemsToView = {
                (favitem,item) in
            DispatchQueue.main.async {
            if let itemData = item {
                self.favoriteList.append(itemData)
                self.FavoriteTableView.reloadData()
                }
            }
            if let favitemData = favitem {
                self.favoriteItemInfoArr.append(favitemData)
               }
    }
   
        favoriteViewModel.bindViewModelErrorToView = {
        
            self.onFailUpdateView()
        }
    }
  
        
        func onFailUpdateView(){
            let alert = UIAlertController(title: "Error", message: favoriteViewModel.showError, preferredStyle: .alert)

            let okAction  = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in


            }
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)

 }
    override func viewWillAppear(_ animated: Bool) {
        self.favoriteList.removeAll()
       // self.FavoriteTableView.reloadData()
        favoriteViewModel.fetchFavorite()
    }
    
    


}
