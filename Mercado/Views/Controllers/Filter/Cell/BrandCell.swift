//
//  BrandFilterTableViewCell.swift
//  Mercado
//
//  Created by Mayar Adel on 6/13/21.
//

import UIKit
extension  UIButton
{
    func checkBox() {
        self.layer.borderWidth = 2
        self.layer.borderColor = #colorLiteral(red: 0.3254901961, green: 0.6941176471, blue: 0.4588235294, alpha: 1)
        self.layer.cornerRadius = 5
    }
}
class BrandCell: UITableViewCell {

    @IBOutlet weak var brandNameLabel: UILabel!
    @IBOutlet weak var brandCheckBox: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        brandCheckBox.checkBox()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
   
}
