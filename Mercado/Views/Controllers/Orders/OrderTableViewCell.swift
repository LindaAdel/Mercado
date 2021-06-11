//
//  OrderTableViewCell.swift
//  Mercado
//
//  Created by Dina ElShabassy on 6/9/21.
//

import UIKit

class OrderTableViewCell: UITableViewCell {

    @IBOutlet weak var orderNo: UILabel!
    @IBOutlet weak var orderTimeStamp: UILabel!
    @IBOutlet weak var orderTotalPrice: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
