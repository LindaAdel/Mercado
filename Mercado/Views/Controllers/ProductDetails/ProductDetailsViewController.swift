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

    var itemDetails : ItemProtocol!
    var images = [InputSource]()
    var categoryName : String!
    override func viewDidLoad() {
        super.viewDidLoad()
        itemPriceLabel.text = itemDetails.item_price!
        itemTitleLabel.text = itemDetails.item_title!
        
        itemDetails.slider_images?.forEach{
            image in
          let img =  AlamofireSource(urlString: image)
           
            images.append(img!)
        
        }
        slideShow.setImageInputs(images)
        //Images Slide show
        slideShow.slideshowInterval = 5
        pageControl.numberOfPages = images.count
        slideShow.pageIndicator = pageControl
        
        
        NotificationCenter.default.post(name:NSNotification.Name(rawValue: "notify"),object:nil,userInfo:["items":itemDetails!,"categoryName":categoryName!])
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
