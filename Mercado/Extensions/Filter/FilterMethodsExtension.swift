//
//  FilterMethodsExtension.swift
//  Mercado
//
//  Created by Mayar Adel on 6/15/21.
//

import UIKit
extension FilterViewController
{
    //MARK:- brand and price filter
    func filterByPriceAndBrand(_ lessThanPriceChoosen:Bool,_ rangePriceChoosen:Bool,_ greaterThanPriceChoosen :Bool){
        if lessThanPriceChoosen
        {
          
            filteredItemsArray = itemsArray.filter {
                let price = Int($0.item_price!)
                return selectedBrandArray.contains($0.brand!) &&  price! < lessThanPrice
            }
        }
        if rangePriceChoosen {
            
            filteredItemsArray = itemsArray.filter {
                let price = Int($0.item_price!)
                return selectedBrandArray.contains($0.brand!) &&  (price! >= rangePrice1 && price! <= rangePrice2 )
            }
        }
        if greaterThanPriceChoosen {
          
            filteredItemsArray = itemsArray.filter {
                let price = Int($0.item_price!)
                return selectedBrandArray.contains($0.brand!) &&  price! > greaterThanPrice
            }
        }
        
    }
    //MARK:- filter by price
    func filterByPriceOnly(_ lessThanPriceChoosen:Bool,_ rangePriceChoosen:Bool,_ greaterThanPriceChoosen :Bool) {
        if lessThanPriceChoosen
        {
           
            filteredItemsArray = itemsArray.filter {
                let price = Int($0.item_price!)
                return price! < lessThanPrice
            }
        }
        if rangePriceChoosen {
    
            filteredItemsArray = itemsArray.filter {
                let price = Int($0.item_price!)
                return (price! >= rangePrice1 && price! <= rangePrice2 )
            }
        }
        if greaterThanPriceChoosen {
          
            filteredItemsArray = itemsArray.filter {
                let price = Int($0.item_price!)
                return  price! > greaterThanPrice
            }
        }
    }
    //MARK:- price radio button
    func updateRadioButton(currentRadioButton:UIButton )
    {
        //to diselect radio button
        guard currentRadioButton.currentImage == nil else {
            currentRadioButton.setImage(nil, for: .normal)
            selectedPriceValue = nil
            return
        }
        
        for radioButton in priceRadioButtonsArray {
            radioButton.setImage(nil, for: .normal)
        }
        currentRadioButton.setImage(UIImage(systemName: "circle.fill"), for: .normal)
 
    }
    
    func getPricesValue()
    {
        if (categoryName == "Women's Fashion" && subCategoryName == "clothing") {
            lessThanPrice = 300
            rangePrice1 = 300
            rangePrice2 = 600
            greaterThanPrice = 600
        } else if (categoryName == "Women's Fashion" && subCategoryName == "bags") {
            lessThanPrice = 400
            rangePrice1 = 400
            rangePrice2 = 700
            greaterThanPrice = 700
            
        } else if ((categoryName == "Girl's Fashion" && subCategoryName == "clothing") ||
                    (categoryName == "Girl's Fashion" && subCategoryName == "shoes") ||
                    (categoryName == "boy's fashion" && subCategoryName == "clothing") ||
                    (categoryName == "boy's fashion" && subCategoryName == "shoes")) {
            
            lessThanPrice = 200
            rangePrice1 = 200
            rangePrice2 = 500
            greaterThanPrice = 500
            
            
        } else if (categoryName == "personalCare" && subCategoryName == "beautyEquipment") {
            
            lessThanPrice = 400
            rangePrice1 = 400
            rangePrice2 = 1000
            greaterThanPrice = 1000
            
        } else if (categoryName == "personalCare" && subCategoryName == "hairStylers") {
            
            lessThanPrice = 400
            rangePrice1 = 400
            rangePrice2 = 1000
            greaterThanPrice = 1000
        } else if (categoryName == "beautyCare" && subCategoryName == "makeUp") {
            
            lessThanPrice = 100
            rangePrice1 = 100
            rangePrice2 = 300
            greaterThanPrice = 300
            
        } else if (categoryName == "beautyCare" && subCategoryName == "skinCare") {
            lessThanPrice = 100
            rangePrice1 = 100
            rangePrice2 = 300
            greaterThanPrice = 300
        } else if ((categoryName == "homeAppliances" && subCategoryName == "blendersAndMixers") ||
                    (categoryName == "homeAppliances" && subCategoryName == "microwaves")) {
            
            lessThanPrice = 1000
            rangePrice1 = 1000
            rangePrice2 = 5000
            greaterThanPrice = 5000
            
            
        } else if ((categoryName == "laptopAndPC" && subCategoryName == "laptops")) {
            
            lessThanPrice = 10000
            rangePrice1 = 10000
            rangePrice2 = 15000
            greaterThanPrice = 15000
            
            
        } else if ((categoryName == "laptopAndPC" && subCategoryName == "laptopBags")) {
            
            lessThanPrice = 400
            rangePrice1 = 400
            rangePrice2 = 600
            greaterThanPrice = 600
        } else if ((categoryName == "mobilesAndTablets" && subCategoryName == "mobiles")) {
            
            lessThanPrice = 3000
            rangePrice1 = 3000
            rangePrice2 =  5000
            greaterThanPrice =  5000
            
        } else if ((categoryName == "mobilesAndTablets" && subCategoryName == "tablets")) {
            
            lessThanPrice = 3000
            rangePrice1 = 3000
            rangePrice2 =  5000
            greaterThanPrice =  5000
            
            
        }
    }
}
