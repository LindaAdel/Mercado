//
//  FilterViewController.swift
//  Mercado
//
//  Created by Mayar Adel on 6/12/21.
//

import UIKit

class FilterViewController: UIViewController {
    var itemsArray :[ItemProtocol]!
    var brandArray :[String] = ["All Brands"]
    var selectedBrandArray:[String]=[]
    @IBOutlet weak var brandTableView: UITableView!
    
    @IBOutlet weak var priceTableView: UITableView!
    
    var lessThanPrice,
        greaterThanPrice,
        rangePrice1,
        rangePrice2 : Int!
    var priceArray:[String]=[]
    var selectedPriceValue:String!
    var categoryName , subCategoryName :String!
    var priceRadioButtonsArray : [UIButton] = []
    var filteredItemsArray : [ItemProtocol]=[]
    override func viewDidLoad()
    {
        super.viewDidLoad()
        brandTableView.tableFooterView = UIView(frame: CGRect.zero)
        
        //get only uniques values in brand
        for item in itemsArray
        {
            brandArray.append(item.brand!)
        }
        brandArray =  Array(Set(brandArray)).sorted()
        print(brandArray)
        //set price range values for each category
        self.getPricesValue()
        
        //price array
        priceArray = [
            "less than \(lessThanPrice!) EGP",
            "\(rangePrice1!) EGP - \(rangePrice2!) EGP",
            "+ \(greaterThanPrice!) EGP",
        ]
        
    }
    
    
    @IBAction func applyFilterButton(_ sender: UIButton)
    {
        
        var lessThanPriceChoosen , rangePriceChoosen,greaterThanPriceChoosen : Bool!
        print("selected \(selectedBrandArray) \(selectedPriceValue)")
        //no filter
        if selectedBrandArray.count == 0 && selectedPriceValue == nil
        {
            print("no filter found")
            filteredItemsArray = itemsArray
            
        }
        if selectedPriceValue != nil {
            lessThanPriceChoosen = selectedPriceValue.contains("less than \(lessThanPrice!) EGP")
            rangePriceChoosen = selectedPriceValue.contains(  "\(rangePrice1!) EGP - \(rangePrice2!) EGP")
            greaterThanPriceChoosen = selectedPriceValue.contains("+ \(greaterThanPrice!) EGP")
        }
        
        if selectedBrandArray.contains("All Brands")
        {
            print("all brands choosen")
            print(itemsArray.count)
            //if user not choose price filter
            if selectedPriceValue == nil  {
                print("all brands only")
                filteredItemsArray = itemsArray
            }
            else{
                filterByPriceOnly(lessThanPriceChoosen,rangePriceChoosen,greaterThanPriceChoosen)
            }
        }
        //choose specific brands
        else if selectedBrandArray.count != 0 || selectedPriceValue != nil{
            print("other")
            if selectedPriceValue == nil  {
                print("filter by brand only")
                filteredItemsArray = itemsArray.filter {
                    return selectedBrandArray.contains($0.brand!)
                }
                
            }
            else{
                
                filterByPriceAndBrand(lessThanPriceChoosen, rangePriceChoosen,greaterThanPriceChoosen)
                
            }
        }
        //filter by price only
        if selectedPriceValue != nil && selectedBrandArray.count == 0 {
            print("filter by price only")
            filterByPriceOnly(lessThanPriceChoosen,rangePriceChoosen,greaterThanPriceChoosen)
            
        }
        
        print(filteredItemsArray)
        
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "filter"), object: nil, userInfo: ["filteredArray":filteredItemsArray])
        self.dismiss(animated: true, completion: nil)
    }
    
}
