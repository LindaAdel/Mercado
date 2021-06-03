//
//  CartViewController.swift
//  Mercado
//
//  Created by Mayar Adel on 5/31/21.
//

import UIKit

class CartViewController: UIViewController {
    
    @IBOutlet weak var subTotalLabel: UILabel!
  
    @IBOutlet weak var shippingLabel: UILabel!
    @IBOutlet weak var totalValueLabel: UILabel!
    var cartViewModel :CartViewModel!
    var itemsArray :[ItemProtocol]!
    var cartItemsArray :[CartItem]!
    @IBOutlet weak var tableView: UITableView!
    var subTotalValue :Float!
    var quantityLabelValue :Int!
    var totalValue : Float!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cartViewModel = CartViewModel()
        subTotalValue = 0.0
        
       
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView(_:)), name: NSNotification.Name(rawValue: "countObserver"), object: nil)
       
    }
    override func viewWillAppear(_ animated: Bool) {
       
        itemsArray = []
        shippingLabel.text = "\(200) EGP"
        cartViewModel.getCartItems()
        self.reloadCartData()
        print("will \(itemsArray.count)")
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
