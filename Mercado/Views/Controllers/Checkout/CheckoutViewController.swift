//
//  CheckoutViewController.swift
//  Mercado
//
//  Created by Dina ElShabassy on 5/31/21.
//

import UIKit

class CheckoutViewController: UIViewController {

    @IBOutlet weak var orderNo: UILabel?
    @IBOutlet weak var orderTimeStamp: UILabel?
    @IBOutlet weak var checkoutItemsTableView: UITableView!
    
    @IBAction func backNavBar(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var placeOrder: UIButton!
    @IBOutlet weak var placeOrderBottomConstraint: NSLayoutConstraint!
    @IBAction func placeOrderBtn(_ sender: Any) {
        
        var orderObj = Order(items: cartItemsArray, shippingAddress: shippingAddress, totalPrice: totalPrice)
        
        firebaseManager.addOrder(orderItem: orderObj)
        firebaseManager.removeCartItems()
        
        let placeOrderVC = storyboard?.instantiateViewController(identifier: "PlaceOrder") as! PlaceOrderViewController
        placeOrderVC.modalPresentationStyle = .fullScreen
        self.present(placeOrderVC, animated: true, completion: nil)
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var cashOnDeliveryImg: UIImageView!
    @IBOutlet weak var itemsCount: UILabel!
    
    @IBAction func editShippingAddressBtn(_ sender: Any) {
        let confrimAddressVc = storyboard?.instantiateViewController(identifier: String(describing: AddAddressTableViewController.self)) as! AddAddressTableViewController
        self.present(confrimAddressVc, animated: true, completion: nil)
    }
    
    @IBOutlet weak var userAddress: UILabel!
    
    @IBOutlet weak var subTotalPrice: UILabel!
    
    @IBOutlet weak var total: UILabel!
    
    var itemsArray :[ItemProtocol]!
    var cartItemsArray :[CartItem]!
    var subTotal : Float!
    var totalPrice : Float!
    var orderObj : Order!
    var shippingAddress : String!
    var firebaseManager : FirebaseManager!
    var ordersItemsArray : [AllItems]!
    var orderTimestamp : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        firebaseManager = FirebaseManager.shared
        
        scrollView.isScrollEnabled = true
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height+100)
        
        NotificationCenter.default.addObserver(self, selector: #selector(presentNoConnectionVC(_:)), name: .internetNotification, object: nil)
        
        cashOnDeliveryImg.image = UIImage(named: "cash_on_delivery")
        
        checkoutItemsTableView.delegate = self
        checkoutItemsTableView.dataSource = self        
        
        subTotalPrice.text = "EGP \(subTotal!)"
        total.text = "EGP \(totalPrice!)"
        
        shippingAddress = "755 Crumm Rd, Cowansville, PA, 16218"
        userAddress.text = shippingAddress
        
        if navigationBar.title == "Order Details"
            {
                orderNo!.text = "Order #\(orderObj.orderNumber!)"
                userAddress.text = orderObj.shippingAddress
                itemsCount.text = "\(ordersItemsArray.count)"
                orderTimeStamp!.text = "Placed on \(orderTimestamp!)"
            }
        else{
            itemsCount.text = "\(itemsArray.count)"
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
