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


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = itemsTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! itemTableViewCell
       // print("cell\(itemsList)")
        cell.cellItemImage.sd_setImage(with: URL(string: self.itemsList[indexPath.row].item_image!))
        cell.cellItemTitle.text = itemsList[indexPath.row].item_title!
        cell.cellItemPrice.text = itemsList[indexPath.row].item_price!
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          return 155
        
      }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailsVC = self.storyboard?.instantiateViewController(withIdentifier: "productDetails") as! ProductDetailsViewController
        detailsVC.categoryName = self.categoryName
        detailsVC.itemDetails=itemsList[indexPath.row]
        self.navigationController!.pushViewController(detailsVC, animated: true)
        
    }
}

