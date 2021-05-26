//
//  ProductDetailsExtension.swift
//  Mercado
//
//  Created by Mayar Adel on 5/21/21.
//

import Foundation
import ImageSlideshow
extension ProductDetailsViewController
{
    //post item details to scrollable container view to update data
    func postItemsNotifier(){
        
        NotificationCenter.default.post(name:NSNotification.Name(rawValue: "notify"),object:nil,userInfo:["items":itemDetails!,"categoryName":categoryName!,"subCategoryName":subCategoryName!])
    }
    
    func showImageSlider()
    {
        //loop in images slider array and get it from alamofire
        itemDetails.slider_images?.forEach{
            image in
          let img =  AlamofireSource(urlString: image)
           
            images.append(img!)
        
        }
        //fit size of image
        slideShow.contentScaleMode = UIViewContentMode.scaleAspectFit
        //set image to slider
        slideShow.setImageInputs(images)
        //Images Slide show
        slideShow.slideshowInterval = 5
        pageControl.numberOfPages = images.count
        slideShow.pageIndicator = pageControl
    }
    
    @objc func didTap() {
        slideShow.presentFullScreenController(from: self)
    }
    
}
