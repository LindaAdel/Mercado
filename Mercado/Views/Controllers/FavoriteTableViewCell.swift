//
//  FavoriteTableViewCell.swift
//  Mercado
//
//  Created by Linda adel on 5/26/21.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var favImageCell: UIImageView!
    
    @IBOutlet weak var favPriceCell: UILabel!
    @IBOutlet weak var favTitleCell: UILabel!
    
    @IBOutlet weak var addToCart: UIButton!
    
    @IBOutlet weak var unFavorite: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func addToCartTapped(_ sender: Any) {
    }
    
    @IBAction func unFavoriteTapped(_ sender: Any) {
    }
    
}
