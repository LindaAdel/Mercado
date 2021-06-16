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
    @IBOutlet weak var favoriteIcon: UIBarButtonItem!
    @IBOutlet weak var cartButton: UIButton!
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var slideShow: ImageSlideshow!
    @IBOutlet weak var itemTitleLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
     
    //to get item details from items view
    var itemDetails : ItemProtocol!
    var categoryName : String!
    var subCategoryName : String!
    //to append images received from alamofire and set it in slide show

    @IBOutlet weak var navItem: UINavigationItem!
    var images = [InputSource]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navItem.title =
            "Item Details"
        itemPriceLabel.text =  "EGP \(itemDetails.item_price!)"
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
        let item = CartItem(category: categoryName!, itemId: itemDetails.item_id!, subCategory: subCategoryName!, count: 1)
        Cart().addToCart(sender: sender, item: item, itemId: itemDetails.item_id!, currentView: self)

    
    }
    
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func favoriteButton(_ sender: UIBarButtonItem) {
    }
}
