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
        if navigationBar.title == "Order Details"{
            self.dismiss(animated: true, completion: nil)
        }
        else{
            self.navigationController?.popViewController(animated: true)
        }
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
        confrimAddressVc.isFromCheckout = true
        self.navigationController?.pushViewController(confrimAddressVc, animated: true)
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
    var addressViewModel : AddressViewModel!
    
    override func viewWillAppear(_ animated: Bool) {
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.tabBarController?.tabBar.isHidden = true
        
        if navigationBar.title == "Order Details"
        {
            self.userAddress.text = orderObj.shippingAddress
        }
        else{
            checkConnectivity()
            addressViewModel = AddressViewModel()
            addressViewModel.getAddressFromFB()
            addressViewModel.bindAddressToAddAddressView = {
                address in
                self.shippingAddress = "\(address!.street!) \(address!.area!),\(address!.apartment!) floor \(address!.floor!), \(address!.country!), \(address!.governorate!)"
                DispatchQueue.main.async {
                    self.userAddress.text = self.shippingAddress
                }
            }
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
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
        
        
        if navigationBar.title == "Order Details"
            {
                orderNo!.text = "Order #\(orderObj.orderNumber!)"
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
