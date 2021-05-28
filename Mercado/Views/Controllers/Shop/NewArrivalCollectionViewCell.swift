//
//  NewArrivalCollectionViewCell.swift
//  Mercado
//
//  Created by Dina ElShabassy on 5/23/21.
//

import UIKit

class NewArrivalCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var price_beforeSale: UILabel!
    
    @IBOutlet weak var favBtn: UIButton!
    var isFavourite : Bool = false
    @IBAction func favBtnAction(_ sender: UIButton) {
//        if isFavourite{
//            favBtn.setImage(UIImage(named: "unfavorite"), for: .normal)
//            isFavourite = false
//        }else{
//            favBtn.setImage(UIImage(named: "favorite"), for: .normal)
//            isFavourite = true
//        }
    }
    
    override func layoutSubviews() {
        // cell rounded section
        self.layer.cornerRadius = 15.0
        self.layer.borderWidth = 5.0
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.masksToBounds = true
        
        // cell shadow section
        self.contentView.layer.cornerRadius = 15.0
        self.contentView.layer.borderWidth = 5.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        self.layer.shadowColor = UIColor.white.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0.0)
        self.layer.shadowRadius = 6.0
        self.layer.shadowOpacity = 0.6
        self.layer.cornerRadius = 15.0
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
    
}
