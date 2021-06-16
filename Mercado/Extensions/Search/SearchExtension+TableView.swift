//
//  SearchExtension+TableView.swift
//  Mercado
//
//  Created by Dina ElShabassy on 6/11/21.
//

import Foundation
import UIKit

extension SearchTableViewController{
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filteredItemsArray.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 155
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as? SearchTableViewCell

        // Configure the cell...
        cell?.itemImage.sd_setImage(with: URL(string: filteredItemsArray[indexPath.row].item_image!), completed: nil)
        cell?.itemTitle.text = filteredItemsArray[indexPath.row].item_title
        cell?.itemPrice.text = "EGP \(filteredItemsArray[indexPath.row].item_price!)"

        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = self.storyboard?.instantiateViewController(withIdentifier: "productDetails") as! ProductDetailsViewController
        detailsVC.modalPresentationStyle = .fullScreen

        let specialItemObj = SpecialItem()
        specialItemObj.category = filteredItemsArray[indexPath.row].category
        specialItemObj.itemId = filteredItemsArray[indexPath.row].itemId
        specialItemObj.subCategory = filteredItemsArray[indexPath.row].subCategory
        
        allItemsViewModel.getItemDetails(filteredItem: specialItemObj)
        
        detailsVC.categoryName = filteredItemsArray[indexPath.row].category
        detailsVC.subCategoryName = filteredItemsArray[indexPath.row].subCategory
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.itemDetailsArray[0].item_id = specialItemObj.itemId
            detailsVC.itemDetails = self.itemDetailsArray[0]
            self.present(detailsVC, animated: true, completion: nil)
        }
        
    }
    
}

