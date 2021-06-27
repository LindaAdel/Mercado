//
//  OrdersViewController.swift
//  Mercado
//
//  Created by Dina ElShabassy on 6/9/21.
//

import UIKit

class OrdersViewController: UIViewController {

    @IBOutlet weak var orderTableView: UITableView!
    @IBAction func backNavBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var noOrdersLabel: UILabel!
    
    @IBOutlet weak var noOrdersImage: UIImageView!
    var ordersViewModel : OrdersViewModel!
    var ordersArray : [Order]!
    var itemsInfoArray : [AllItems]!
    var activityIndicator : UIActivityIndicatorView! = UIActivityIndicatorView(style: .large)
    
    override func viewWillAppear(_ animated: Bool) {
        checkConnectivity()
        showLoading(activityIndicator: activityIndicator)
        ordersArray.removeAll()
        itemsInfoArray.removeAll()
        orderTableView.reloadData()
        ordersViewModel.fetchOrdersArray()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        orderTableView.delegate = self
        orderTableView.dataSource = self
        
        ordersViewModel = OrdersViewModel()
        ordersArray = [Order]()
        itemsInfoArray = [AllItems]()
        
        ordersViewModel.bindOrdersViewModelToView = {
            self.onSuccessUpdateView()
        }
        
        ordersViewModel.bindItemInfoViewModelToView = {
            (item) in
            if let itemData = item{
                self.hideLoading(activityIndicator: self.activityIndicator)
                self.itemsInfoArray.append(itemData)
            
            }
          
        }
        
        ordersViewModel.bindViewModelErrorToView = {
            self.onFailUpdateView()
        }
        
        ordersViewModel.bindEmptyOrdersToView = {
            self.onEmptyOrderView()
        }
    }
    

    

}
