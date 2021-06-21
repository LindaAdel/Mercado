//
//  SearchTableViewController.swift
//  Mercado
//
//  Created by Dina ElShabassy on 6/10/21.
//

import UIKit
import SDWebImage

class SearchTableViewController: UITableViewController{
    
    var allItemsViewModel : SearchItemViewModel!
    var filteredItemsArray : [AllItems]!
    var itemDetailsArray : [ItemProtocol]!
    var firebaseManager : FirebaseManager!
    var activityIndicator : UIActivityIndicatorView! = UIActivityIndicatorView(style: .large)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        allItemsViewModel = SearchItemViewModel()
        filteredItemsArray = []
        firebaseManager = FirebaseManager.shared
        itemDetailsArray = [ItemProtocol]()
        
        allItemsViewModel.bindDetailsItemToView = {
                 (data) in
            if let itemData = data{
                self.itemDetailsArray.removeAll()
                self.itemDetailsArray.append(itemData)
                            
            }
        }
        
        
        allItemsViewModel.bindFilteredItemsModelToView = {
            self.onSuccessUpdateView()
        }
        
        allItemsViewModel.bindViewModelErrorToView = {
            self.onFailUpdateView()
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.filteredItemsArray.removeAll()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.itemDetailsArray.removeAll()
    }



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//Hide tab bar
//override func viewWillAppear(_ animated: Bool) {
//       self.tabBarController?.tabBar.isHidden = true
//   }
//
//   override func viewWillDisappear(_ animated: Bool) {
//       self.tabBarController?.tabBar.isHidden = false
//   }
