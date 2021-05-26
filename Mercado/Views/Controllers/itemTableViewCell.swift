//
//  itemTableViewCell.swift
//  Mercado
//
//  Created by Linda adel on 5/18/21.
//

import UIKit

class itemTableViewCell: UITableViewCell {

    
    @IBOutlet weak var cellItemImage: UIImageView!
    
    @IBOutlet weak var cellItemTitle: UILabel!
    
    @IBOutlet weak var cellItemPrice: UILabel!
    
    @IBOutlet weak var cellAddToCart: UIButton!
    
    @IBOutlet weak var cellAddToFavorite: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func AddToCartBtnTapped(_ sender: Any) {
    }
    
    @IBAction func addToFavoriteBtnTapped(_ sender: Any) {
    }
    
    
}
