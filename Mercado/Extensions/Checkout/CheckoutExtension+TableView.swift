//
//  CheckoutExtension+TableView.swift
//  Mercado
//
//  Created by Dina ElShabassy on 6/1/21.
//

import Foundation
import UIKit

extension CheckoutViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.layer.cornerRadius = 15
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CheckoutItemTableViewCell
        cell?.itemImage.sd_setImage(with: URL(string: "https://media.btech.com/media/catalog/product/cache/ead4866c641338b50cadbc0815eacb19/n/l/nl_mc455tbrcsr-eu_018_001_black.jpg"))
        print("\(itemsArray[indexPath.row].item_image!)")
        cell?.itemTitle.text =  "\(itemsArray[indexPath.row].item_title!)"
        cell?.itemAmount.text = "x\(cartItemsArray[indexPath.row].count!)"
        cell?.itemPrice.text = "EGP \(itemsArray[indexPath.row].item_price!)"
        
        return cell!
    }
    
    
}
