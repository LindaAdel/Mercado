//
//  ScrollableProductDetailsViewController.swift
//  Mercado
//
//  Created by Mayar Adel on 5/19/21.
//

import UIKit

class ScrollableProductDetailsViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
         //  scrollView.isScrollEnabled = true
        scrollView.contentSize = CGSize(width: scrollView.contentSize.width, height: 1200)
        
        // Do any additional setup after loading the view.
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
