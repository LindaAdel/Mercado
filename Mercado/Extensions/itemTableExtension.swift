//
//  itemTableExtension.swift
//  Mercado
//
//  Created by Linda adel on 5/18/21.
//

import Foundation
import UIKit
import SDWebImage


extension itemsTableViewController : UITableViewDelegate,UITableViewDataSource{


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailsVC = self.storyboard?.instantiateViewController(withIdentifier: "productDetails") as! ProductDetailsViewController
        detailsVC.categoryName = self.categoryName
        detailsVC.itemDetails=itemsList[indexPath.row]
        detailsVC.subCategoryName = subCategoryObj.subcategoryName
        self.navigationController!.pushViewController(detailsVC, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
                     return searchingItem.count
                 } else {
                     return itemsList.count
                 }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = itemsTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! itemTableViewCell
        
        if isSearching {
            
            cell.cellItemImage.sd_setImage(with: URL(string: self.searchingItem[indexPath.row].item_image!))
            cell.cellItemTitle.text = searchingItem[indexPath.row].item_title!
            cell.cellItemPrice.text = searchingItem[indexPath.row].item_price!
            cell.cellAddToFavorite.tag = indexPath.row
            cell.cellAddToFavorite.addTarget(self, action: #selector(navigation), for: .touchUpInside)
            cell.isFavorite = false
          } else {
            cell.cellItemImage.sd_setImage(with: URL(string: self.itemsList[indexPath.row].item_image!))
            cell.cellItemTitle.text = itemsList[indexPath.row].item_title!
            cell.cellItemPrice.text = itemsList[indexPath.row].item_price!
            cell.cellAddToFavorite.tag = indexPath.row
            cell.cellAddToFavorite.addTarget(self, action: #selector(navigation), for: .touchUpInside)
            cell.isFavorite = false
          }
 
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          return 155
        
      }
    
    @objc func navigation(sender : UIButton)
        {
           let indexp = IndexPath(row: sender.tag, section: 0)
  
        var cellFavoriteItem : Favorite = Favorite()
        cellFavoriteItem.categoryName = self.itemcategoryName
        cellFavoriteItem.subcategoryName = subCategoryObj.itemSubCategoryName
        cellFavoriteItem.item_id = itemsList[indexp.row].item_id
        if itemIsFavorite {
            itemService.removeItemsFromFavorites(favoriteItem: cellFavoriteItem)
            itemIsFavorite = false
        }else{
            itemService.addItemsToFavorites(favoriteItem: cellFavoriteItem)
            itemIsFavorite = true
        }
       
       
        }
}

extension itemsTableViewController : UISearchBarDelegate {
   
    func searchBar(_ itemsSearchBar : UISearchBar, textDidChange searchText: String) {
        searchingItem = itemsList.filter({$0.brand!.prefix(searchText.count) == searchText.lowercased()})
            isSearching = true
            itemsTableView.reloadData()
        }
        
    
}



