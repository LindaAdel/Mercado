//
//  ProductDetailsViewController.swift
//  Mercado
//
//  Created by Mayar Adel on 5/19/21.
//

import UIKit
import ImageSlideshow
class ProductDetailsViewController: UIViewController {
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var slideShow: ImageSlideshow!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slideShow.slideshowInterval = 5
        slideShow.setImageInputs([
            ImageSource(image: UIImage(named: "carts")!),
            ImageSource(image: UIImage(named: "shopping")!),
        ])
        pageControl.numberOfPages = 2
        slideShow.pageIndicator = pageControl
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
