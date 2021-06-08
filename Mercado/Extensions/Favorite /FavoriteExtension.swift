//
//  FavoriteExtension.swift
//  Mercado
//
//  Created by Linda adel on 5/22/21.
//

import Foundation
import UIKit
import SDWebImage


extension FavoriteTableViewController : UITableViewDelegate,UITableViewDataSource{

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailsVC = self.storyboard?.instantiateViewController(withIdentifier: "productDetails") as! ProductDetailsViewController
        
        detailsVC.categoryName = favoriteItemInfoArr[indexPath.row].category
        favoriteList[indexPath.row].item_id =  favoriteItemInfoArr[indexPath.row].itemId!
        detailsVC.itemDetails=favoriteList[indexPath.row]
        detailsVC.subCategoryName = subCategoryObj.itemSubCategoryName
        detailsVC.modalPresentationStyle = .fullScreen
        self.present(detailsVC, animated: true, completion: nil)
    
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   //if(tableView == FavoriteTableView){
    let favcell = FavoriteTableView.dequeueReusableCell(withIdentifier: "favcell", for: indexPath) as! FavoriteTableViewCell
        favcell.favImageCell.sd_setImage(with: URL(string: favoriteList[indexPath.row].item_image!))
       
        favcell.favTitleCell.text = favoriteList[indexPath.row].item_title
        favcell.favPriceCell.text = "EGP \(favoriteList[indexPath.row].item_price!)"
        favcell.unFavorite.tag = indexPath.row
        favcell.unFavorite.addTarget(self, action: #selector(unFavoriteBtn), for: .touchUpInside)
               
    return favcell
       
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          return 155
        
      }
    @objc func unFavoriteBtn(sender : UIButton)
    {
        let indexp = IndexPath(row: sender.tag, section: 0)
        let cellFavoriteItem : SpecialItem = SpecialItem()
        itemcategoryName = favoriteItemInfoArr[indexp.row].category
        cellFavoriteItem.category = self.itemcategoryName
        cellFavoriteItem.subCategory = subCategoryObj.itemSubCategoryName
        cellFavoriteItem.itemId = favoriteItemInfoArr[indexp.row].itemId
        let verifyAlert = UIAlertController(title: "Alert", message: " Are you sure you want to unfavorite this item ", preferredStyle: .alert)
        verifyAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
            self.firebaseManager.removeItemsFromFavorites(favoriteItem: cellFavoriteItem)
            self.favoriteList.remove(at: indexp.row)
            self.favoriteItemInfoArr.remove(at: indexp.row)
            self.FavoriteTableView.reloadData()
        }))
        verifyAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(verifyAlert, animated: true, completion: nil)
    }
    
    
   
}

