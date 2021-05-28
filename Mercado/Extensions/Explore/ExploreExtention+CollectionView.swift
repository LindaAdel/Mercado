//
//  ExploreExtention+CollectionView.swift
//  Mercado
//
//  Created by Dina ElShabassy on 5/18/21.
//

import Foundation
import UIKit
import SDWebImage

extension ExploreTabBarController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.categoriesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CategoriesCollectionViewCell
        
     
        
        cell.categoryIcon.sd_setImage(with: URL(string: categoriesArray[indexPath.row].categoryIcon))

        cell.categoryName.text = categoriesArray[indexPath.row].categoryName
       
        
        self.collectionView(categoriesCollectionView, didSelectItemAt: IndexPath(row: 0, section: 0))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.collectionView(categoriesCollectionView, didDeselectItemAt: IndexPath(row: 0, section: 0))
        
         let cell = collectionView.cellForItem(at: indexPath)
         cell?.isSelected = true
        
        subCatgeoryArray = categoriesArray[indexPath.row].subCategories
        subCategoriesTableView.reloadData()
        categoryName = categoriesArray[indexPath.row].categoryName
        itemcategoryName = categoriesArray[indexPath.row].itemsCategoryName
       // print("hh \(itemcategoryName!)")
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath){
        
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.isSelected = false
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 125)
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

