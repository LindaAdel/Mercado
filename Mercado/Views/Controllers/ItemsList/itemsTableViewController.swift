//
//  itemsTableViewController.swift
//  Mercado
//
//  Created by Linda adel on 5/17/21.
//

import UIKit
import FittedSheets

class itemsTableViewController: UIViewController {
    
    
    var subCategoryObj = SubCategory(subcategoryAPI: "", subcategoryName: "" ,itemSubCategoryName: "" )
    
    var categoryName : String?
    var itemcategoryName : String?
    var itemIsFavoriteArr : [ItemIsFavorite?] = []
    var searchingItem = [ItemProtocol]()
    var isSearching : Bool = false
    var favoriteItem = SpecialItem()
    var itemsList: [ItemProtocol] = []
    var allItemsToFilter: [ItemProtocol] = []
    var itemsViewModel : ItemsViewModel!
    //var itemService : itemsService!
    var firebaseManager : FirebaseManager!
    var activityIndicator : UIActivityIndicatorView! = UIActivityIndicatorView(style: .large)
    
    
    @IBOutlet weak var itemsSearchBar: UISearchBar!
    @IBOutlet weak var itemsTableView: UITableView!
    @IBAction func backNavBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func updateFilteredArray(_ notifications:Notification)
    {
        if let data = notifications.userInfo
        {
            let filteredItemsArray = data["filteredArray"] as! [ItemProtocol]
            print("filter notified")
            self.itemsList = filteredItemsArray
            self.itemsTableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showLoading(activityIndicator: activityIndicator)
        itemsList.removeAll()
        itemIsFavoriteArr.removeAll()
        itemsTableView.reloadData()
        itemsViewModel.fetchItemsDataFromAPI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemsTableView.delegate = self
        itemsTableView.dataSource = self
        firebaseManager = FirebaseManager.shared
        NotificationCenter.default.addObserver(self, selector: #selector(updateFilteredArray(_:)), name: NSNotification.Name(rawValue: "filter"), object: nil)
        
        itemsViewModel = ItemsViewModel(subCategoryObj: self.subCategoryObj, categoryName: self.itemcategoryName!)
        //itemsViewModel.fetchItemsDataFromAPI()
        
        
        
        
        itemsViewModel.bindItemsToView = {
            (items) in
            
            self.hideLoading(activityIndicator: self.activityIndicator)
            self.itemsList = items
            self.allItemsToFilter = items
            
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
                self.hideLoading(activityIndicator: self.activityIndicator)
                self.itemsTableView.reloadData()
            }
            
            
        }
        
        itemsViewModel.bindViewModelErrorToView = {
            
            self.onFailUpdateView()
        }
        
    }
    
    
    func onFailUpdateView(){
        hideLoading(activityIndicator: activityIndicator)
        let alert = UIAlertController(title: "Error", message: itemsViewModel.showError, preferredStyle: .alert)
        
        let okAction  = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
            
            
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    @IBAction func FilterButton(_ sender: Any) {
        let filterVC = storyboard?.instantiateViewController(withIdentifier: String(describing: FilterViewController.self)) as! FilterViewController
        print(itemsList.count)
        filterVC.itemsArray = self.allItemsToFilter
        filterVC.categoryName = self.itemcategoryName
        filterVC.subCategoryName = self.subCategoryObj.itemSubCategoryName
        let sheetController = SheetViewController(controller: filterVC,  sizes: [.marginFromTop(self.view.frame.size.height/3), .percent(0), .fixed(self.view.frame.size.height/3),.marginFromTop(self.view.frame.size.height/3)])
        
        self.present(sheetController, animated: true, completion: nil)
    }
}



