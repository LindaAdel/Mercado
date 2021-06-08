//
//  ShopTabBarController.swift
//  Mercado
//
//  Created by Dina ElShabassy on 5/19/21.
//

import UIKit
import ImageSlideshow
import Firebase

class ShopTabBarController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var imageSlider: ImageSlideshow!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var newArrivalCollectionView: UICollectionView!
    @IBOutlet weak var exclusiveOffersCollectionView: UICollectionView!
    
    var images = [InputSource]()
    var newArrival_array : [ItemProtocol]!
    var newArrival_infoArray : [SpecialItem]!
    var exclusive0ffers_infoArray : [SpecialItem]!
    var exclusiveOffers_array : [ItemProtocol]!
    var newArrivalViewModel : NewArrivalViewModel!
    var exclusiveViewModel : ExclusiveOffersViewModel!
    var firebaseManager : FirebaseManager!
    var itemIsFavoriteArr : [ItemIsFavorite?]!
    var collectionView :UICollectionView!
    var flashSaleViewModel : FlashSaleViewModel!
    var flashSaleArray : [FlashSale]!

    override func viewWillAppear(_ animated: Bool) {
        print("shop will appear")
        //update cart badge
        CartHandlerViewModel().getNumbersOfItemsInCart()
        NotificationCenter.default.addObserver(self,selector:#selector(updateBadgeValue(_:)),name:NSNotification.Name(rawValue: "cartBadge"),object:nil)
    }
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
            print("badgee from shop\(numberOfItemsInCart!)")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
         
      
        // Do any additional setup after loading the view.
        newArrivalViewModel = NewArrivalViewModel()
        exclusiveViewModel = ExclusiveOffersViewModel()
        
        flashSaleViewModel = FlashSaleViewModel()
        flashSaleArray = [FlashSale]()
        
        flashSaleViewModel.bindFlashSaleViewModelToView = {
            self.onSuccessUpdateView()
        }
        
        flashSaleViewModel.bindViewModelErrorToView = {
            self.onFailUpdateView()
        }

        scrollView.isScrollEnabled = true
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height+100)

        showSliderImages()

        newArrivalCollectionView.delegate = self
        newArrivalCollectionView.dataSource = self

        exclusiveOffersCollectionView.delegate = self
        exclusiveOffersCollectionView.dataSource = self

        newArrivalViewModel.fetchAllNewArrivalItems()
        newArrival_array = [ItemProtocol]()
        newArrival_infoArray = [SpecialItem]()
        exclusive0ffers_infoArray = [SpecialItem]()
        firebaseManager = FirebaseManager.shared
        itemIsFavoriteArr = [ItemIsFavorite?]()
       // itemIsFavoriteArr =
        

        newArrivalViewModel.bindItemsToView = {
                (newArrrivalInfo,data) in
            if let itemData = data{
                //print(itemData.item_price)
                self.newArrival_array.append(itemData)
                
                DispatchQueue.main.async {
                    self.newArrivalCollectionView.reloadData()
                }
//                for i in 0...self.newArrival_array.count-1 {
//                    self.newArrivalViewModel.itemIsFavoriteValue(itemIdValue: itemData.item_id!, index: i)
//
//                }
                
            }

            if let itemDetails = newArrrivalInfo{
                self.newArrival_infoArray.append(itemDetails)
            }
            
//            self.itemIsFavoriteArr = [ItemIsFavorite?](repeating: nil, count: self.newArrival_array.count)
//            DispatchQueue.main.async {
//                self.newArrivalCollectionView.reloadData()
//            }
//
//            for i in 0...self.newArrival_array.count-1 {
//                    self.newArrivalViewModel.itemIsFavoriteValue(itemIdValue: self.newArrival_array[i].item_id!, index: i)
//
//                }

       }
        
        
        
//            self.newArrivalViewModel.bindItemFavoriteToView = {
//                (isFav,index) in
//            self.itemIsFavoriteArr[index] = ItemIsFavorite(isFavorite: isFav)
//              print(index , isFav)
//                DispatchQueue.main.async {
//                    self.newArrivalCollectionView.reloadData()
//                }
//        }
                

        exclusiveViewModel.fetchAllExclusiveOffersItems()
        exclusiveOffers_array = [ItemProtocol]()

         exclusiveViewModel.bindItemsToView = {
                 (exclusiveOffersInfo,item) in
             if let itemData = item{
                 //print(itemData.item_price)
                 self.exclusiveOffers_array.append(itemData)
                 DispatchQueue.main.async {
                     self.exclusiveOffersCollectionView.reloadData()
                 }
             }

            if let itemInfo = exclusiveOffersInfo{
                self.exclusive0ffers_infoArray.append(itemInfo)
            }
        }


               
    }
    
    func onSuccessUpdateView(){
        
        flashSaleArray = flashSaleViewModel.flashSaleArray
        DispatchQueue.main.async {
            self.showSliderImages()
        }
    }
    
    func onFailUpdateView(){
        
       
        let alert = UIAlertController(title: "Error", message: flashSaleViewModel.showError, preferredStyle: .alert)
        
        let okAction  = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
            
        }
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func showSliderImages() {
        
        //loop in images slider array and get it from alamofire
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
