//
//  CartTableViewCell.swift
//  Mercado
//
//  Created by Mayar Adel on 5/31/21.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var cellBackgroundView: UIView!
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    
    var quantityValue : Int!
    var currentCartId :String!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        print("cellllll")
//        quantityLabel.text = String(quantityValue!)
    //set border to the quantity value
      quantityLabel.layer.borderWidth = 2
      quantityLabel.layer.borderColor = #colorLiteral(red: 0.3254901961, green: 0.6941176471, blue: 0.4588235294, alpha: 1)
      quantityLabel.layer.cornerRadius = 10
    //cell background
      cellBackgroundView.layer.cornerRadius = 10
      cellBackgroundView.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func plusButton(_ sender: Any) {
        quantityValue += 1
        guard quantityValue >= 1  else {
            return
        }
        
        //    print("quantity\(quantityValue)")
        quantityLabel.text = String(quantityValue)
        FirebaseManager.shared.updateCountValue(countValue:quantityValue, currentCartId: self.currentCartId)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "countObserver"), object: nil, userInfo: nil)
    }
    @IBAction func minusButton(_ sender: Any) {
        quantityValue -= 1
        guard quantityValue >= 1  else {
            return
        }
        
        quantityLabel.text = String(quantityValue)
        FirebaseManager.shared.updateCountValue(countValue:quantityValue, currentCartId: self.currentCartId)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "countObserver"), object: nil, userInfo: nil)
     //   print(quantityValue)

    }
}
