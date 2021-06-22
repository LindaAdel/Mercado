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
    var newArrivalIsFavoriteArr : [ItemIsFavorite?]!
    var exclusiveOffersIsFavoriteArr : [ItemIsFavorite?]!
    var collectionView :UICollectionView!
    var flashSaleViewModel : FlashSaleViewModel!
    var flashSaleArray : [FlashSale] = [FlashSale]()
    var searchController : UISearchController? = nil
    var activityIndicator : UIActivityIndicatorView! = UIActivityIndicatorView(style: .large)

    override func viewWillAppear(_ animated: Bool) {
        checkConnectivity()
        print("shop will appear")
        //update cart badge
        showLoading(activityIndicator: activityIndicator)
        CartHandlerViewModel().getNumbersOfItemsInCart()
        NotificationCenter.default.addObserver(self,selector:#selector(updateBadgeValue(_:)),name:NSNotification.Name(rawValue: "cartBadge"),object:nil)
        
        flashSaleArray.removeAll()
        images.removeAll()
        flashSaleViewModel.fetchFlashSaleArray()
        
        newArrival_array.removeAll()
        newArrival_infoArray.removeAll()
        newArrivalIsFavoriteArr.removeAll()
        newArrivalCollectionView.reloadData()
        newArrivalViewModel.fetchAllNewArrivalItems()
        
        exclusiveOffers_array.removeAll()
        exclusive0ffers_infoArray.removeAll()
        exclusiveOffersIsFavoriteArr.removeAll()
        exclusiveOffersCollectionView.reloadData()
        exclusiveViewModel.fetchAllExclusiveOffersItems()
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
         
      
        // Do any additional setup after loading the view.
        
        
        //search
        self.showSearchBar()
        
        newArrivalViewModel = NewArrivalViewModel()
        exclusiveViewModel = ExclusiveOffersViewModel()
        
        flashSaleViewModel = FlashSaleViewModel()
        
        flashSaleViewModel.bindFlashSaleViewModelToView = {
            self.onSuccessUpdateView()
        }
        
        flashSaleViewModel.bindViewModelErrorToView = {
            self.onFailUpdateView()
        }

        scrollView.isScrollEnabled = true
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height+100)

        

        newArrivalCollectionView.delegate = self
        newArrivalCollectionView.dataSource = self

        exclusiveOffersCollectionView.delegate = self
        exclusiveOffersCollectionView.dataSource = self

        newArrival_array = [ItemProtocol]()
        newArrival_infoArray = [SpecialItem]()
        exclusive0ffers_infoArray = [SpecialItem]()
        firebaseManager = FirebaseManager.shared
        newArrivalIsFavoriteArr = [ItemIsFavorite?]()
        exclusiveOffersIsFavoriteArr = [ItemIsFavorite?]()
        exclusiveOffers_array = [ItemProtocol]()
        

        newArrivalViewModel.bindItemsToView = {
                (newArrrivalInfo,data) in
            if let itemData = data , let itemDetails = newArrrivalInfo{
                self.newArrival_array.append(itemData)
                self.newArrival_infoArray.append(itemDetails)
                
                DispatchQueue.main.async {
                    self.hideLoading(activityIndicator: self.activityIndicator)
                    self.newArrivalCollectionView.reloadData()
                }
            }
                
        }
        
        newArrivalViewModel.bindItemFavoriteToView = {
                (isFav) in
            self.newArrivalIsFavoriteArr.append(ItemIsFavorite(isFavorite: isFav))
            print(isFav)
            DispatchQueue.main.async {
                self.hideLoading(activityIndicator: self.activityIndicator)
                self.newArrivalCollectionView.reloadData()
            }
        }

         exclusiveViewModel.bindItemsToView = {
                 (exclusiveOffersInfo,item) in
             if let itemData = item, let itemInfo = exclusiveOffersInfo{
                
                 self.exclusiveOffers_array.append(itemData)
                 self.exclusive0ffers_infoArray.append(itemInfo)
                 DispatchQueue.main.async {
                    self.hideLoading(activityIndicator: self.activityIndicator)
                     self.exclusiveOffersCollectionView.reloadData()
                 }
             }

        }
        
        exclusiveViewModel.bindItemFavoriteToView = {
                (isFav) in
            self.exclusiveOffersIsFavoriteArr.append(ItemIsFavorite(isFavorite: isFav))
            print(isFav)
            DispatchQueue.main.async {
                self.hideLoading(activityIndicator: self.activityIndicator)
                self.exclusiveOffersCollectionView.reloadData()
            }
        }


               
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
