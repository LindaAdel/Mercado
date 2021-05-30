//
//  ShopExtension+CollecionView.swift
//  Mercado
//
//  Created by Dina ElShabassy on 5/23/21.
//

import Foundation
import UIKit
import SDWebImage

extension ShopTabBarController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == newArrivalCollectionView{
            return newArrival_array.count
        }else if collectionView == exclusiveOffersCollectionView{
            return exclusiveOffers_array.count
        }else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == newArrivalCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newArrivalCell", for: indexPath) as! NewArrivalCollectionViewCell
        
            cell.itemTitle.text = newArrival_array[indexPath.row].item_title
            cell.itemImage.sd_setImage(with: URL(string: newArrival_array[indexPath.row].item_image!))
            cell.itemPrice.text = "EGP \(newArrival_array[indexPath.row].item_price!)"
//            cell.favBtn.addTarget(self, action: #selector(favoriteBtnAction), for: .touchUpInside)
//            
//                        if let favFlag = self.itemIsFavoriteArr[indexPath.row]{
//                            if favFlag.isFavorite! {
//                                cell.favBtn.setImage(UIImage(named: "favorite"), for: .normal)
//                            }else {
//                                cell.favBtn.setImage(UIImage(named: "unfavorite"), for: .normal)
//                            }
//                        }

            return cell
        }
        else if collectionView == exclusiveOffersCollectionView{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "offersCell", for: indexPath) as! NewArrivalCollectionViewCell

            cell.itemTitle.text = exclusiveOffers_array[indexPath.row].item_title!
            cell.itemImage.sd_setImage(with: URL(string: exclusiveOffers_array[indexPath.row].item_image!))
            cell.itemPrice.text = "EGP \(exclusiveOffers_array[indexPath.row].price_afterSale!!)"
            
            //stikeThrough Text
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "EGP \(exclusiveOffers_array[indexPath.row].item_price!)")
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
            attributeString.addAttribute(NSAttributedString.Key.strikethroughColor, value: UIColor.red, range: NSMakeRange(0, attributeString.length))
            
            cell.price_beforeSale.attributedText = attributeString

            return cell
                
        }else {
            preconditionFailure("Unknown collection view!")
        }
        
    }
    
    
    @objc func favoriteBtnAction(sender : UIButton)
            {
//               let indexp = IndexPath(row: sender.tag, section: 0)
//            var cellFavoriteItem : Favorite = Favorite()
//                cellFavoriteItem.categoryName = newArrival_infoArray[indexp.row].category
//            cellFavoriteItem.subcategoryName = newArrival_infoArray[indexp.row].subCategory
//            cellFavoriteItem.item_id = newArrival_array[indexp.row].item_id
//
//            if let favFlag = self.itemIsFavoriteArr[indexp.row]{
//                if favFlag.isFavorite! {
//                    firebaseManager.removeItemsFromFavorites(favoriteItem: cellFavoriteItem)
//                    self.itemIsFavoriteArr[indexp.row]?.isFavorite = false
//                }else {
//                    firebaseManager.addItemsToFavorites(favoriteItem: cellFavoriteItem)
//                    self.itemIsFavoriteArr[indexp.row]?.isFavorite = true
//                }
//            }
//            self.newArrivalCollectionView.reloadData()
            }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsVC = self.storyboard?.instantiateViewController(withIdentifier: "productDetails") as! ProductDetailsViewController
        if collectionView == newArrivalCollectionView{
            
            detailsVC.categoryName = newArrival_infoArray[indexPath.row].category
            detailsVC.itemDetails = newArrival_array[indexPath.row]
            detailsVC.subCategoryName = newArrival_infoArray[indexPath.row].subCategory
        
        }
        else if collectionView == exclusiveOffersCollectionView{
            
            detailsVC.categoryName = exclusive0ffers_infoArray[indexPath.row].category
            detailsVC.itemDetails = exclusiveOffers_array[indexPath.row]
            detailsVC.subCategoryName = exclusive0ffers_infoArray[indexPath.row].subCategory
            
        }
        self.present(detailsVC, animated: true, completion: nil)

    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath){
        
//        let cell = collectionView.cellForItem(at: indexPath)
//        cell?.isSelected = false
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 227)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    
    
    
}
