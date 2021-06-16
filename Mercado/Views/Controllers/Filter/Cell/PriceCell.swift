//
//  PriceCell.swift
//  Mercado
//
//  Created by Mayar Adel on 6/14/21.
//

import UIKit
extension  UIButton
{
    func radioButton() {
        self.layer.borderWidth = 2
        self.layer.borderColor = #colorLiteral(red: 0.3254901961, green: 0.6941176471, blue: 0.4588235294, alpha: 1)
        self.layer.cornerRadius = 15
    }
}
class PriceCell: UITableViewCell {

    @IBOutlet weak var priceRadioButton: UIButton!
    @IBOutlet weak var priceValueLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        priceRadioButton.radioButton()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
