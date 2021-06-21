//
//  FavoriteTableViewController.swift
//  Mercado
//
//  Created by Linda adel on 5/22/21.
//

import UIKit

class FavoriteTableViewController: UIViewController {
    
    
    @IBOutlet weak var noFavImage: UIImageView!
    @IBOutlet weak var noFavLabel: UILabel!
    var subCategoryObj = SubCategory(subcategoryAPI: "", subcategoryName: ""
        , itemSubCategoryName: "")
    var categoryName : String?
    var itemcategoryName : String?
    var favoriteItemInfoArr : [SpecialItem]!
    var itemId : String?
    var favoriteItem = SpecialItem()
    var subCategoryName : String?
    var favoriteList : [ItemProtocol]!
    var favoriteViewModel : FavoriteViewModel!
    //var itemService : itemsService!
    var firebaseManager : FirebaseManager!
    var activityIndicator : UIActivityIndicatorView! = UIActivityIndicatorView(style: .large)
    
 
    @IBOutlet weak var FavoriteTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
       
        FavoriteTableView.delegate = self
        FavoriteTableView.dataSource = self
        
        favoriteViewModel = FavoriteViewModel()
        favoriteList = [ItemProtocol]()
        favoriteItemInfoArr = [SpecialItem]()
        //itemService = itemsService()
        firebaseManager = FirebaseManager.shared
        favoriteViewModel.bindEmptyFavToView = {
            DispatchQueue.main.async {[self] in
                print("no fav")
               hideLoading(activityIndicator: activityIndicator)
               noFavLabel.isHidden
                 = false
                noFavImage.isHidden = false
                FavoriteTableView.isHidden = true
            }
        }
        favoriteViewModel.bindItemsToView = {
                (favitem,item) in
            DispatchQueue.main.async {
                self.FavoriteTableView.isHidden = false
                self.hideLoading(activityIndicator: self.activityIndicator)
                if let itemData = item,  let favitemData = favitem {
                self.favoriteList.append(itemData)
                self.favoriteItemInfoArr.append(favitemData)
                self.FavoriteTableView.reloadData()
                }
            }
    }
   
        favoriteViewModel.bindViewModelErrorToView = {
        
            self.onFailUpdateView()
        }
    }
  
        
        func onFailUpdateView(){
            hideLoading(activityIndicator: activityIndicator)
            let alert = UIAlertController(title: "Error", message: favoriteViewModel.showError, preferredStyle: .alert)

            let okAction  = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in


            }
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)

 }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showLoading(activityIndicator: activityIndicator)
        self.favoriteList.removeAll()
        self.favoriteItemInfoArr.removeAll()
        self.FavoriteTableView.reloadData()
        favoriteViewModel.fetchFavorite()
    }
    
    


}
