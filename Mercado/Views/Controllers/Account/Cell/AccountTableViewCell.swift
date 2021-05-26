//
//  AccountTableViewCell.swift
//  Mercado
//
//  Created by Mayar Adel on 5/22/21.
//

import UIKit

class AccountTableViewCell: UITableViewCell {

    @IBOutlet weak var accountDetailsLabel: UILabel!
    @IBOutlet weak var accountDetailsIcon: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
