//
//  ScrollableDetailsExtension.swift
//  Mercado
//
//  Created by Mayar Adel on 5/21/21.
//

import Foundation

extension ScrollableProductDetailsViewController
{
    //add observer to listen to item details sent from product details view
    func addObserverToItems() {
        NotificationCenter.default.addObserver(self,selector:#selector(updateScrollableViewWithItemDetails(_:)),name:NSNotification.Name(rawValue: "notify"),object:nil)
    }
    func showLabels()
    {
        itemCountryLabel.isHidden = false
        itemCountryLabelValue.isHidden = false
        itemPowerLabel.isHidden = false
        itemPowerLabelValue.isHidden = false
        itemCapacityLabel.isHidden = false
        itemCapacityLabelValue.isHidden = false
    }
    func hideLabels()
    {
        itemCountryLabel.isHidden = true
        itemCountryLabelValue.isHidden = true
        itemPowerLabel.isHidden = true
        itemPowerLabelValue.isHidden = true
        itemCapacityLabel.isHidden = true
        itemCapacityLabelValue.isHidden = true
    }
    //update scrollable when product details post item details
    @objc func updateScrollableViewWithItemDetails(_ notifications:Notification)
{
        if let data = notifications.userInfo
        {
            self.hideLabels()
            //get item details from observer
            let item=data["items"] as! ItemProtocol
            if let _ = item.type
                        {
            
                itemTypeLabelValue.text = item.size as? String
                        }
            else
            {
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
               // print(itemSizeLabelValue.text)
            }
            switch data["categoryName"] as! String{
            case "personalCare":
                itemSizeLabel.text = "Features"
                itemTypeLabel.text = "Model Number"
                itemSizeLabelValue.text = item.item_features as? String
                itemTypeLabelValue.text = item.model_number as? String
                itemMaterialLabel.isHidden = true
                itemMaterialLabelValue.isHidden = true
                itemBrandLabel.text = item.brand
                itemColorLabelValue.text = item.color as? String
            case "beautyCare":
                itemBrandLabel.text = item.brand
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
            case "homeAppliances":
                print("home")
                showLabels()
                itemCountryLabelValue.text = item.country as? String
                itemSizeLabel.text = "Power"
                itemSizeLabelValue.text = item.power as? String
                itemMaterialLabel.text = "Model-number"
                itemMaterialLabelValue.text = item.model_number as? String
                itemCapacityLabelValue.text = item.item_capacity as? String
          //      print("features\(item.item_features)")
                itemPowerLabel.text = "Features"
                itemPowerLabelValue.text = item.item_features as? String
                itemTypeLabelValue.text = item.type as? String
                itemBrandLabel.text = item.brand
                itemColorLabelValue.text = item.color as? String
            case "mobilesAndTablets":
                self.showLabels()
                itemTypeLabel.text = "Battery Capacity"
                itemTypeLabelValue.text = item.battery_capacity as? String
                itemMaterialLabel.text = "Connectiviy"
                itemMaterialLabelValue.text = item.connectivity as? String
                itemSizeLabel.text = "Memory"
                itemSizeLabelValue.text = item.memory as? String
                itemCountryLabel.text = "Processor"
                itemCountryLabelValue.text = item.processor as? String
                itemPowerLabel.text = "Front Camera"
                itemPowerLabelValue.text = item.front_camera as? String
                itemCapacityLabel.text = "Rear Camera"
                itemCapacityLabelValue.text = item.rear_camera as? String
                itemBrandLabel.text = item.brand
                itemColorLabelValue.text = item.color as? String
            case "laptopAndPC":
                switch data["subCategoryName"] as! String {
                case "laptops":
                    showLabels()
                    itemBrandLabel.text = item.brand
                    itemColorLabelValue.text = item.color as? String
                    
                    itemTypeLabel.text = "Model"
                    itemTypeLabelValue.text = item.model as? String
                    itemMaterialLabel.text = "Operating System"
                    itemMaterialLabelValue.text = item.operating_system as? String
                    itemSizeLabel.text = "Ram"
                    itemSizeLabelValue.text = item.ram as? String
                    itemCountryLabel.text = "Processor"
                    itemCountryLabelValue.text = item.processor as? String
                    itemPowerLabel.text = "Storage"
                    itemPowerLabelValue.text = item.storage as? String
                    itemCapacityLabel.text = "Display Size"
                    itemCapacityLabelValue.text = item.display_size as? String
                case "laptopBags":
                    showLabels()
                    itemBrandLabel.text = item.brand
                    itemColorLabelValue.text = item.color as? String
                    
                    itemTypeLabel.text = "Model"
                    itemTypeLabelValue.text = item.model as? String
                    itemMaterialLabel.text = "Warranty Years"
                    itemMaterialLabelValue.text = item.warranty_years as? String
                    itemSizeLabel.text = "Water Resistant"
                    itemSizeLabelValue.text = item.water_resistant as? String
                    itemCountryLabel.isHidden = true
                    itemCountryLabelValue.isHidden = true
                    itemPowerLabel.text = "Compatible With"
                    itemPowerLabelValue.text = item.compatible_with as? String
                    itemCapacityLabel.isHidden = true
                    itemCapacityLabelValue.isHidden = true
                default:
                    print("bags")
                }
            default:
                print("other category")
                itemBrandLabel.text = item.brand
                itemColorLabelValue.text = item.color as? String
                itemMaterialLabelValue.text = item.material as? String
                itemSizeLabelValue.text = item.size as? String
                itemTypeLabelValue.text = item.type as? String
            }
            //print("category name")
        //    print(data["categoryName"])
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
  
}
