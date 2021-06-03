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
        detailsVC.categoryName = self.itemcategoryName
        detailsVC.itemDetails=itemsList[indexPath.row]
        detailsVC.subCategoryName = subCategoryObj.itemSubCategoryName
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
        //MARK:- Cart
        cell.cellAddToCart.addTarget(self, action: #selector(addToCartButton), for: .touchUpInside)
        Cart().checkIfItemInCart(button :cell.cellAddToCart,itemId:itemsList[indexPath.row].item_id!)
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
    //MARK:- Cart
    @objc func addToCartButton(_ sender :UIButton)
    {
        let indexPath = IndexPath(row: sender.tag, section: 0)
        let item = CartItem(category: itemcategoryName, itemId: itemsList[indexPath.row].item_id, subCategory: subCategoryObj.itemSubCategoryName, count: 1)
        Cart().addToCart(sender: sender, item: item, itemId: itemsList[indexPath.row].item_id!)
    }
    @objc func favoriteBtnAction(sender : UIButton)
        {
           let indexp = IndexPath(row: sender.tag, section: 0)
            let cellFavoriteItem : SpecialItem = SpecialItem()
        cellFavoriteItem.category = self.itemcategoryName
        cellFavoriteItem.subCategory = subCategoryObj.itemSubCategoryName
        cellFavoriteItem.itemId = itemsList[indexp.row].item_id
        
        if let favFlag = self.itemIsFavoriteArr[indexp.row]{
            if favFlag.isFavorite! {
                firebaseManager.removeItemsFromFavorites(favoriteItem: cellFavoriteItem)
                self.itemIsFavoriteArr[indexp.row]?.isFavorite = false
            }else {
                firebaseManager.addItemsToFavorites(favoriteItem: cellFavoriteItem)
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



