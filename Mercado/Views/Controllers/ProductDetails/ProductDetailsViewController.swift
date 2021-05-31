//
//  ProductDetailsViewController.swift
//  Mercado
//
//  Created by Mayar Adel on 5/19/21.
//

import UIKit
import ImageSlideshow
class ProductDetailsViewController: UIViewController
{
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var slideShow: ImageSlideshow!
    @IBOutlet weak var itemTitleLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
     
    //to get item details from items view
    var itemDetails : ItemProtocol!
    var categoryName : String!
    var subCategoryName : String!
    //to append images received from alamofire and set it in slide show
    var images = [InputSource]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemPriceLabel.text = itemDetails.item_price!
        itemTitleLabel.text = itemDetails.item_title!
        
        //show image slider
        self.showImageSlider()
        
        //send item details to scrollabe container view
        self.postItemsNotifier()
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ProductDetailsViewController.didTap))
        slideShow.addGestureRecognizer(gestureRecognizer)
        
    }
    

    @IBAction func addToCartButton(_ sender: UIButton)
    {
        if sender.backgroundColor !=  #colorLiteral(red: 0.9529411765, green: 0.3764705882, blue: 0.2470588235, alpha: 1){
            sender.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.3764705882, blue: 0.2470588235, alpha: 1)
            sender.setImage(UIImage(systemName: "checkmark"), for: .normal)
        }
        else
        {
            sender.backgroundColor = #colorLiteral(red: 0.3254901961, green: 0.6941176471, blue: 0.4588235294, alpha: 1)
        //    sender.tintColor = .white
            sender.setImage(UIImage(systemName: "cart.badge.plus.fill"), for: .normal)
        }
       
    
    }
    
}
