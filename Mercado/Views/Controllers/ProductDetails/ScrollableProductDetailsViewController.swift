//
//  ScrollableProductDetailsViewController.swift
//  Mercado
//
//  Created by Mayar Adel on 5/19/21.
//

import UIKit

class ScrollableProductDetailsViewController: UIViewController {
    @IBOutlet weak var itemCapacityLabelValue: UILabel!
    @IBOutlet weak var itemCapacityLabel: UILabel!
    @IBOutlet weak var itemPowerLabelValue: UILabel!
    @IBOutlet weak var itemPowerLabel: UILabel!
    
    @IBOutlet weak var itemCountryLabelValue: UILabel!
    @IBOutlet weak var itemCountryLabel: UILabel!
    
    @IBOutlet weak var itemSizeLabelValue: UILabel!
    
    @IBOutlet weak var itemTypeLabelValue: UILabel!
    @IBOutlet weak var itemColorLabelValue: UILabel!
    @IBOutlet weak var itemTypeLabel: UILabel!
    @IBOutlet weak var itemMaterialLabel: UILabel!
    @IBOutlet weak var itemSizeLabel: UILabel!
    @IBOutlet weak var itemMaterialLabelValue: UILabel!
    @IBOutlet weak var itemColorLabel: UILabel!
    @IBOutlet weak var itemBrandLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
         //  scrollView.isScrollEnabled = true
        //set height ro scrollview
        scrollView.contentSize = CGSize(width: scrollView.contentSize.width, height: 1200)
        
        //add observer to listen to item details sent from product details view
        self.addObserverToItems()
        
    }
  



}
