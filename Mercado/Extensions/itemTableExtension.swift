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
        //detailsVC.modalPresentationStyle = .fullScreen
        self.present(detailsVC, animated: true, completion: nil)
       // self.navigationController!.pushViewController(detailsVC, animated: true)
        
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
            cell.cellAddToFavorite.addTarget(self, action: #selector(favoriteBtnAction), for: .touchUpInside)
           
          } else {
            cell.cellItemImage.sd_setImage(with: URL(string: self.itemsList[indexPath.row].item_image!))
            cell.cellItemTitle.text = itemsList[indexPath.row].item_title!
            cell.cellItemPrice.text = "EGP \(itemsList[indexPath.row].item_price!)"
            cell.cellAddToFavorite.tag = indexPath.row
            cell.cellAddToFavorite.addTarget(self, action: #selector(favoriteBtnAction), for: .touchUpInside)
//            if ((self.itemIsFavoriteArr[indexPath.row]?.isFavorite!) != nil){
//                cell.cellAddToFavorite.setImage(UIImage(named: "favorite"), for: .normal)
//
//            }else {
//
//                cell.cellAddToFavorite.setImage(UIImage(named: "unfavorite"), for: .normal)
//            }
            if let favFlag = self.itemIsFavoriteArr[indexPath.row]{
                if favFlag.isFavorite! {
                    cell.cellAddToFavorite.setImage(UIImage(named: "favorite"), for: .normal)
                }else {
                    cell.cellAddToFavorite.setImage(UIImage(named: "unfavorite"), for: .normal)
                }
            }
           
          }
 
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          return 155
        
      }
    
    @objc func favoriteBtnAction(sender : UIButton)
        {
           let indexp = IndexPath(row: sender.tag, section: 0)
        var cellFavoriteItem : Favorite = Favorite()
        cellFavoriteItem.categoryName = self.itemcategoryName
        cellFavoriteItem.subcategoryName = subCategoryObj.itemSubCategoryName
        cellFavoriteItem.item_id = itemsList[indexp.row].item_id
        
//        if ((self.itemIsFavoriteArr[indexp.row]?.isFavorite!) != nil){
//            itemService.removeItemsFromFavorites(favoriteItem: cellFavoriteItem)
//            self.itemIsFavoriteArr[indexp.row]?.isFavorite = false
//
//        }else{
//            itemService.addItemsToFavorites(favoriteItem: cellFavoriteItem)
//            self.itemIsFavoriteArr[indexp.row]?.isFavorite = true
//        }
        if let favFlag = self.itemIsFavoriteArr[indexp.row]{
            if favFlag.isFavorite! {
                itemService.removeItemsFromFavorites(favoriteItem: cellFavoriteItem)
                self.itemIsFavoriteArr[indexp.row]?.isFavorite = false
            }else {
                itemService.addItemsToFavorites(favoriteItem: cellFavoriteItem)
                self.itemIsFavoriteArr[indexp.row]?.isFavorite = true
            }
        }
        self.itemsTableView.reloadData()
        }
}

extension itemsTableViewController : UISearchBarDelegate {
   
    func searchBar(_ itemsSearchBar : UISearchBar, textDidChange searchText: String) {
        searchingItem = itemsList.filter({$0.brand!.prefix(searchText.count) == searchText.lowercased()})
            isSearching = true
            itemsTableView.reloadData()
        }
        
    
}



