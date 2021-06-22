//
//  CartViewController.swift
//  Mercado
//
//  Created by Mayar Adel on 5/31/21.
//

import UIKit

class CartViewController: UIViewController {
    

    @IBOutlet weak var cartTabBarIcon: UITabBarItem!
    @IBOutlet weak var subTotalLabel: UILabel!
    @IBOutlet weak var shippingLabel: UILabel!
    @IBOutlet weak var totalValueLabel: UILabel!
    var cartViewModel :CartViewModel!
    var itemsArray :[ItemProtocol]!
    var cartItemsArray :[CartItem]!
    @IBAction func checkoutBtnAction(_ sender: Any) {
        
        let checkoutVC = storyboard?.instantiateViewController(identifier: "Checkout") as! CheckoutViewController
        checkoutVC.modalPresentationStyle = .fullScreen
        checkoutVC.itemsArray = itemsArray!
        checkoutVC.cartItemsArray = cartItemsArray!
        checkoutVC.subTotal = subTotalValue!
        checkoutVC.totalPrice = totalValue!
        self.navigationController?.pushViewController(checkoutVC, animated: true)
    }
    @IBOutlet weak var tableView: UITableView!
    var subTotalValue :Float!
    var quantityLabelValue :Int!
    var totalValue : Float!
    var shippingValue : Float!
    var emptyCartbackgroundImage :UIImageView!
    var activityIndicator : UIActivityIndicatorView! = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //initialize variable
        cartViewModel = CartViewModel()
        itemsArray = []
        cartItemsArray = []
        subTotalValue = 0.0
        shippingValue = 100.0
        shippingLabel.text = "\(shippingValue!) EGP"
        emptyCartbackgroundImage = UIImageView(frame: UIScreen.main.bounds)
        
        //binding with cart view model
        self.reloadCartData()
        //binding empty cart frim cart view model
        self.emptyCart()   
       //add obsever when count value change
        self.observeToCountValue()
        
        self.observeToCartBadge()
        cartTabBarIcon.badgeColor = #colorLiteral(red: 0.9529411765, green: 0.3764705882, blue: 0.2470588235, alpha: 1)
      
       
    }
  
   
    override func viewWillAppear(_ animated: Bool) {
        checkConnectivity()
        showLoading(activityIndicator: activityIndicator)
        CartHandlerViewModel().getNumbersOfItemsInCart()
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        if Connectivity.isConnectedToInternet{
            cartViewModel.getCartItems()
        }
        print("cart will appear \(itemsArray.count)")

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    

}
