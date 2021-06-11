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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        orderTableView.delegate = self
        orderTableView.dataSource = self
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
