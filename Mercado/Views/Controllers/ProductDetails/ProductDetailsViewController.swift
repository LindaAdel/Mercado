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
    
    var productDetailsViewModel : ProductDetailsViewModel!
    var isFavorite : Bool!
    var firebaseManager : FirebaseManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firebaseManager = FirebaseManager.shared
        productDetailsViewModel = ProductDetailsViewModel()
        productDetailsViewModel.itemIsFavoriteValue(itemIdValue: itemDetails.item_id!)
        
        productDetailsViewModel.bindItemFavoriteToView = {
              (isFav) in
            DispatchQueue.main.async {
                self.isFavorite = isFav
                if isFav{
                    self.favoriteIcon.image = UIImage(named: "favorite")
                }
                else{
                     self.favoriteIcon.image = UIImage(named: "unfavorite")
                }
            }
        }
        
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
        
        let cellFavoriteItem : SpecialItem = SpecialItem()
        cellFavoriteItem.category = categoryName!
        cellFavoriteItem.subCategory = subCategoryName!
        cellFavoriteItem.itemId = itemDetails.item_id!

            if isFavorite {
                let verifyAlert = UIAlertController(title: "Alert", message: " Are you sure you want to unfavorite this item ", preferredStyle: .alert)
                verifyAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
                    self.favoriteIcon.image = UIImage(named: "unfavorite")
                    self.firebaseManager.removeItemsFromFavorites(favoriteItem: cellFavoriteItem)
                    self.isFavorite = false
                }))
                verifyAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                self.present(verifyAlert, animated: true, completion: nil)
                
            }else {
                self.favoriteIcon.image = UIImage(named: "favorite")
                firebaseManager.addItemsToFavorites(favoriteItem: cellFavoriteItem)
                isFavorite = true
            }
        }
    
}
