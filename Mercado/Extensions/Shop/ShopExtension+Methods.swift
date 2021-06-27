//
//  ShopExtension+Methods.swift
//  Mercado
//
//  Created by Dina ElShabassy on 6/11/21.
//

import Foundation
import UIKit
import ImageSlideshow

extension ShopTabBarController{
    
    @objc func updateBadgeValue(_ notifications:Notification)
       {
           if let data = notifications.userInfo
           {
               let numberOfItemsInCart = data["numberOfItems"] as? Int
               if numberOfItemsInCart == 0
               {
                   DispatchQueue.main.async {
                   self.tabBarController!.viewControllers![2].tabBarItem.badgeValue = nil
                   }
               }
               else{
               DispatchQueue.main.async {
                   self.tabBarController!.viewControllers![2].tabBarItem.badgeValue = String(numberOfItemsInCart!)
               }}
             
           }
       }
    
    func onSuccessUpdateView(){
        flashSaleArray = flashSaleViewModel.flashSaleArray
        DispatchQueue.main.async {
            self.hideLoading(activityIndicator: self.activityIndicator)
            self.showSliderImages()
        }
    }
    
    func onFailUpdateView(){
        
        hideLoading(activityIndicator: activityIndicator)
        let alert = UIAlertController(title: "Error", message: flashSaleViewModel.showError, preferredStyle: .alert)
        
        let okAction  = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
            
        }
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func showSliderImages() {
        
        //loop in images slider array and get it from alamofire
        images.removeAll()
        flashSaleArray.forEach{
            item in
            let img =  AlamofireSource(urlString: item.image!)
           
            images.append(img!)
        
        }
        //fit size of image
        imageSlider.contentScaleMode = UIViewContentMode.scaleAspectFill
        //set image to slider
        imageSlider.setImageInputs(images)
        //Images Slide show
        imageSlider.slideshowInterval = 5
        pageControl.numberOfPages = images.count
        imageSlider.pageIndicator = pageControl
    }
    
    //add search bar to the view
        func showSearchBar()  {
            //search
            let searchItemsVC = storyboard!.instantiateViewController(withIdentifier: "SearchItems") as! SearchTableViewController
            //to display search results in location search table view
            searchController = UISearchController(searchResultsController: searchItemsVC)
            searchController?.searchResultsUpdater = searchItemsVC
            
            //configures the search bar, and embeds it within the navigation bar
            let searchBar = searchController?.searchBar
    //        searchBar?.sizeToFit()
            searchBar?.placeholder = "Search for items"
            searchController?.hidesNavigationBarDuringPresentation = false
            navigationItem.hidesSearchBarWhenScrolling = false
            
            navigationItem.titleView = searchBar
            
            searchController?.obscuresBackgroundDuringPresentation = true
            definesPresentationContext = true
            
            //change cancel button color
            UIBarButtonItem.appearance(whenContainedInInstancesOf:[UISearchBar.self]).tintColor = UIColor.black
        }
    
}
