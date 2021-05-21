//
//  ScrollableProductDetailsViewController.swift
//  Mercado
//
//  Created by Mayar Adel on 5/19/21.
//

import UIKit

class ScrollableProductDetailsViewController: UIViewController {
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
        scrollView.contentSize = CGSize(width: scrollView.contentSize.width, height: 1200)
        
        NotificationCenter.default.addObserver(self,selector:#selector(updateView(_:)),name:NSNotification.Name(rawValue: "notify"),object:nil)
        
        // Do any additional setup after loading the view.
    }
    //using observer
    @objc func updateView(_ notifications:Notification)
{
        if let data = notifications.userInfo
        {
            let item=data["items"] as! ItemProtocol
            print(item.size)
            if let _ = item.type
                        {
            
                itemTypeLabelValue.text = item.size as? String
                        }
            else
            {
                print("nill type")
                itemTypeLabelValue.text = "-"
            }
            if let _ = item.size
                        {
            
                itemSizeLabelValue.text = item.size as? String
                        }
            else
            {
                itemSizeLabelValue.text = "-"
                print("nil size")
                print(itemSizeLabelValue.text)
            }
            switch data["categoryName"] as! String{
            case "Personal Care":
                itemSizeLabel.text = "Featue"
                itemTypeLabel.text = "Model Number"
                itemSizeLabelValue.text = item.item_features as? String
                itemTypeLabelValue.text = item.model_number as? String
                itemMaterialLabel.isHidden = true
                itemMaterialLabelValue.isHidden = true
            case "Beauty Care":

                itemTypeLabel.text = "size"
                itemSizeLabel.text = "Description"
                itemColorLabel.text = "Texture"
                if let _ = item.type
                            {
                
                    itemTypeLabelValue.text = item.size as? String
                            }
                else
                {
                    itemTypeLabelValue.text = "-"
                }
                if let _ = item.texture
                            {
                
                    itemColorLabelValue.text = item.texture as? String
                            }
                else
                {
                    itemColorLabel.isHidden = true
                    itemColorLabelValue.isHidden = true
                }
                itemSizeLabelValue.text = item.item_description as? String
                
         
                itemMaterialLabel.isHidden = true
                itemMaterialLabelValue.isHidden = true
                
            default:
                print("other category")
                itemBrandLabel.text = item.brand
                itemColorLabelValue.text = item.color as? String
                itemMaterialLabelValue.text = item.material as? String
                itemSizeLabelValue.text = item.size as? String
                itemTypeLabelValue.text = item.type as? String
            }
            print("category name")
            print(data["categoryName"])
//            let item=data["items"] as! ItemProtocol
//            if let _ = item.type
//            {
//
//                itemTypeLabelValue.text = item.type as? String
//
//            }
//            else
//            {
//                print("nul")
//                itemTypeLabel.isHidden = true
//                itemTypeLabelValue.isHidden = true
//            }

            
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
