//
//  CheckoutViewController.swift
//  Mercado
//
//  Created by Dina ElShabassy on 5/31/21.
//

import UIKit

class CheckoutViewController: UIViewController {

    @IBOutlet weak var checkoutItemsTableView: UITableView!
    
    @IBAction func backNavBar(_ sender: Any) {
        
    }
    
    @IBAction func placeOrderBtn(_ sender: Any) {
        
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        scrollView.isScrollEnabled = true
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height+100)
        
        NotificationCenter.default.addObserver(self, selector: #selector(presentNoConnectionVC(_:)), name: .InternetNotification, object: nil)
        
        cashOnDeliveryImg.image = UIImage(named: "cash_on_delivery")
        
        checkoutItemsTableView.delegate = self
        checkoutItemsTableView.dataSource = self
        
        itemsCount.text = "3"
        
        userAddress.text = "755 Crumm Rd, Cowansville, PA, 16218"

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
