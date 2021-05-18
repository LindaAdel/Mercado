//
//  itemTableExtension.swift
//  Mercado
//
//  Created by Linda adel on 5/18/21.
//

import Foundation
import UIKit
import SDWebImage


extension itemsTableViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
extension itemsTableViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = itemsTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! itemTableViewCell
        cell.cellItemImage.sd_setImage(with: URL(string: self.itemsList[indexPath.row].item_image!))
        cell.cellItemTitle.text = itemsList[indexPath.row].item_details!
        cell.cellItemPrice.text = itemsList[indexPath.row].item_price!
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          return 155
        
      }
}

