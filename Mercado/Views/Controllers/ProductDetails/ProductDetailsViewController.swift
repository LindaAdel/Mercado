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
        
    }
    


}
