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
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.layer.cornerRadius = 15
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CheckoutItemTableViewCell
        cell?.itemImage.sd_setImage(with: URL(string: "https://m.media-amazon.com/images/I/61FQOmp8x-L._AC_UL320_.jpg"))
        cell?.itemTitle.text = "Revlon ColorStay 16 Hour Eyeshadow Quad with Dual-Ended Applicator Brush, Longwear, Intense Color Smooth Eye Makeup for Day & Night, Moonlit (555), 0.16 oz"
        cell?.itemAmount.text = "x\(2)"
        cell?.itemPrice.text = "EGP \(83.32)"
        
        return cell!
    }
    
    
}
