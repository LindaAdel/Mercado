//
//  CategoriesCollectionViewCell.swift
//  Mercado
//
//  Created by Dina ElShabassy on 5/18/21.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {
   
    @IBOutlet weak var categoryIcon: UIImageView!
    @IBOutlet weak var categoryName: UILabel!
    
    
    override var isSelected: Bool {
        
        didSet {
            if self.isSelected{
                categoryName.textColor = UIColor(red: 69/255, green: 165/255, blue: 98/255, alpha: 1.0)
                self.backgroundColor? = .white
                
            }
            else{
                self.backgroundColor? = UIColor(red: 224/255, green: 255/255, blue: 225/255, alpha: 1.0)
                categoryName.textColor = .black
            }
        }
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
