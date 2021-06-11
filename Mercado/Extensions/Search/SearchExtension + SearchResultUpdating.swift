//
//  SearchExtension + SearchResultUpdating.swift
//  Mercado
//
//  Created by Dina ElShabassy on 6/10/21.
//

import Foundation
import UIKit

extension SearchTableViewController : UISearchResultsUpdating{
    
    func updateSearchResults(for searchController: UISearchController) {
        
        let searchBarTextValue = searchController.searchBar.text
        allItemsViewModel.fetchFilteredItemsArray(searchKey: searchBarTextValue!)
        
    }
    
    func onSuccessUpdateView(){
        
        self.filteredItemsArray.removeAll()
        filteredItemsArray = allItemsViewModel.filteredItemsArray
        self.tableView.reloadData()
    }
    
    func onFailUpdateView(){
        
       
        let alert = UIAlertController(title: "Error", message: allItemsViewModel.showError, preferredStyle: .alert)
        
        let okAction  = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
            
        }
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
}
