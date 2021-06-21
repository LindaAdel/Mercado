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
            cell.addToCartBtn.addTarget(self, action: #selector(addToCartNewArrivalButton), for: .touchUpInside)
            print("id \(newArrival_infoArray .count)")
            print("id \(newArrival_array .count)")

            cell.addToCartBtn.tag = indexPath.row
//            Cart().checkIfItemInCart(button :cell.addToCartBtn,itemId:newArrival_infoArray [indexPath.row].itemId!)
            cell.itemTitle.text = newArrival_array[indexPath.row].item_title!
            cell.itemImage.sd_setImage(with: URL(string: newArrival_array[indexPath.row].item_image!))
            cell.itemPrice.text = "EGP \(newArrival_array[indexPath.row].item_price!)"
            cell.favBtn.tag = indexPath.row
            cell.favBtn.addTarget(self, action: #selector(newArrivalFavoriteBtnAction), for: .touchUpInside)

            if let favFlag = self.newArrivalIsFavoriteArr[indexPath.row]{
                if favFlag.isFavorite! {
                    cell.favBtn.setImage(UIImage(named: "favorite"), for: .normal)
                }else {
                    cell.favBtn.setImage(UIImage(named: "unfavorite"), for: .normal)
                }
            }

            return cell
        }
        else if collectionView == exclusiveOffersCollectionView{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "offersCell", for: indexPath) as! NewArrivalCollectionViewCell
            cell.addToCartBtn.addTarget(self, action: #selector(addToCartOfferslButton), for: .touchUpInside)
            cell.addToCartBtn.tag = indexPath.row
//            Cart().checkIfItemInCart(button :cell.addToCartBtn,itemId:exclusive0ffers_infoArray [indexPath.row].itemId!)
            cell.itemTitle.text = exclusiveOffers_array[indexPath.row].item_title!
            cell.itemImage.sd_setImage(with: URL(string: exclusiveOffers_array[indexPath.row].item_image!))
            cell.itemPrice.text = "EGP \(exclusiveOffers_array[indexPath.row].item_price!)"
            
            //favorite
            cell.favBtn.tag = indexPath.row
            cell.favBtn.addTarget(self, action: #selector(exclusiveOffersFavoriteBtnAction), for: .touchUpInside)

            if let favFlag = self.exclusiveOffersIsFavoriteArr[indexPath.row]{
                if favFlag.isFavorite! {
                    cell.favBtn.setImage(UIImage(named: "favorite"), for: .normal)
                }else {
                    cell.favBtn.setImage(UIImage(named: "unfavorite"), for: .normal)
                }
            }
            
            //stikeThrough Text
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "EGP \(exclusiveOffers_array[indexPath.row].oldPrice!!)")
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
            attributeString.addAttribute(NSAttributedString.Key.strikethroughColor, value: UIColor.red, range: NSMakeRange(0, attributeString.length))
            
            cell.price_beforeSale.attributedText = attributeString

            return cell
                
        }else {
            preconditionFailure("Unknown collection view!")
        }
        
    }
    
    
    @objc func newArrivalFavoriteBtnAction(sender : UIButton)
            {
               let indexp = IndexPath(row: sender.tag, section: 0)
                let cellFavoriteItem : SpecialItem = SpecialItem()
            cellFavoriteItem.category = newArrival_infoArray[indexp.row].category
            cellFavoriteItem.subCategory = newArrival_infoArray[indexp.row].subCategory
            newArrival_array[indexp.row].item_id = newArrival_infoArray[indexp.row].itemId
            cellFavoriteItem.itemId = newArrival_array[indexp.row].item_id

            if let favFlag = self.newArrivalIsFavoriteArr[indexp.row]{
                if favFlag.isFavorite! {
                    firebaseManager.removeItemsFromFavorites(favoriteItem: cellFavoriteItem)
                    self.newArrivalIsFavoriteArr[indexp.row]?.isFavorite = false
                }else {
                    firebaseManager.addItemsToFavorites(favoriteItem: cellFavoriteItem)
                    self.newArrivalIsFavoriteArr[indexp.row]?.isFavorite = true
                }
            }
            self.newArrivalCollectionView.reloadData()
            }
    
    @objc func exclusiveOffersFavoriteBtnAction(sender : UIButton)
    {
           let indexp = IndexPath(row: sender.tag, section: 0)
            let cellFavoriteItem : SpecialItem = SpecialItem()
        cellFavoriteItem.category = exclusive0ffers_infoArray[indexp.row].category
        cellFavoriteItem.subCategory = exclusive0ffers_infoArray[indexp.row].subCategory
        exclusiveOffers_array[indexp.row].item_id = exclusive0ffers_infoArray[indexp.row].itemId
        cellFavoriteItem.itemId = exclusiveOffers_array[indexp.row].item_id

        if let favFlag = self.exclusiveOffersIsFavoriteArr[indexp.row]{
            if favFlag.isFavorite! {
                firebaseManager.removeItemsFromFavorites(favoriteItem: cellFavoriteItem)
                self.exclusiveOffersIsFavoriteArr[indexp.row]?.isFavorite = false
            }else {
                firebaseManager.addItemsToFavorites(favoriteItem: cellFavoriteItem)
                self.exclusiveOffersIsFavoriteArr[indexp.row]?.isFavorite = true
            }
        }
        self.exclusiveOffersCollectionView.reloadData()
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsVC = self.storyboard?.instantiateViewController(withIdentifier: "productDetails") as! ProductDetailsViewController
        if collectionView == newArrivalCollectionView{
            
            detailsVC.categoryName = newArrival_infoArray[indexPath.row].category
            print("shop\(newArrival_array[indexPath.row].item_id)")
            newArrival_array[indexPath.row].item_id = newArrival_infoArray[indexPath.row].itemId
            detailsVC.itemDetails = newArrival_array[indexPath.row]
            detailsVC.subCategoryName = newArrival_infoArray[indexPath.row].subCategory
        
        }
        else if collectionView == exclusiveOffersCollectionView{
//            print("shop\(newArrival_array[indexPath.row].item_id)")
            detailsVC.categoryName = exclusive0ffers_infoArray[indexPath.row].category
            exclusiveOffers_array[indexPath.row].item_id = exclusive0ffers_infoArray[indexPath.row].itemId
            detailsVC.itemDetails = exclusiveOffers_array[indexPath.row]
            detailsVC.subCategoryName = exclusive0ffers_infoArray[indexPath.row].subCategory
            
        }
        detailsVC.modalPresentationStyle = .fullScreen
        self.present(detailsVC, animated: true, completion: nil)

    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath){
        
//        let cell = collectionView.cellForItem(at: indexPath)
//        cell?.isSelected = false
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == newArrivalCollectionView{
            return CGSize(width: collectionView.bounds.width, height: 258)
        }
        else{
            return CGSize(width: collectionView.bounds.width, height: 227)
        }
        
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
    
    
    
    //MARK:- Cart
    @objc func addToCartNewArrivalButton(_ sender :UIButton)
    {
       
        let indexPath = IndexPath(row: sender.tag, section: 0)
        let item = CartItem(category:newArrival_infoArray[indexPath.row].category , itemId: newArrival_infoArray[indexPath.row].itemId, subCategory: newArrival_infoArray[indexPath.row].subCategory, count: 1)
        print("id add \(newArrival_infoArray[indexPath.row].itemId!)")
//        print(newArrival_infoArray.count)
//        print(newArrival_array.count)
//        print(indexPath)
        Cart().addToCart(sender: sender, item: item, itemId: newArrival_infoArray[indexPath.row].itemId!, currentView: self)
    }
    @objc func addToCartOfferslButton(_ sender :UIButton)
    {
        let indexPath = IndexPath(row: sender.tag, section: 0)
        let item = CartItem(category: exclusive0ffers_infoArray[indexPath.row].category, itemId: exclusive0ffers_infoArray[indexPath.row].itemId, subCategory: exclusive0ffers_infoArray[indexPath.row].subCategory, count: 1)
        Cart().addToCart(sender: sender, item: item, itemId: exclusive0ffers_infoArray[indexPath.row].itemId!, currentView: self)
    }
}
