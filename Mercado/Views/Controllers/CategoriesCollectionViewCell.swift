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
    
    
    
}
