//
//  BrandTableViewExtension.swift
//  Mercado
//
//  Created by Mayar Adel on 6/13/21.
//

import UIKit
extension FilterViewController:UITableViewDelegate,UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case brandTableView:
            return  brandArray.count
        case priceTableView :
            return priceArray.count
        default:
            return   0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case brandTableView:
            let brandCell = tableView.dequeueReusableCell(withIdentifier: String(describing: BrandCell.self) ,for: indexPath)as! BrandCell
            
            brandCell.brandNameLabel.text = brandArray[indexPath.row]
            brandCell.brandCheckBox.tag = indexPath.row
            brandCell.brandCheckBox.addTarget(self, action: #selector(brandCheckBoxButton), for: .touchUpInside)
            
            return brandCell
        default:
            print("price cell reloaded")
            let priceCell = tableView.dequeueReusableCell(withIdentifier: String(describing: PriceCell.self) ,for: indexPath)as! PriceCell
            priceCell.priceRadioButton.tag = indexPath.row
            priceCell.priceRadioButton.addTarget(self, action: #selector(priceCheckBoxButton), for: .touchUpInside)
            priceCell.priceValueLabel.text = priceArray[indexPath.row]
            priceRadioButtonsArray.append(priceCell.priceRadioButton)
            return priceCell
        }
        
    }
    @objc func priceCheckBoxButton(_ sender:UIButton)
    {
        
        let indexPath = IndexPath(row: sender.tag, section: 0)
        //set filter by price value
        selectedPriceValue = priceArray[indexPath.row]
        //radio buttons updates
        self.updateRadioButton(currentRadioButton: sender)
        
        
    }
    @objc func brandCheckBoxButton(_ sender:UIButton,tableView:UITableView)
    {
        
        
        let indexPath = IndexPath(row: sender.tag, section: 0)
        if sender.currentImage == nil
        {
            sender.setImage(UIImage(systemName: "checkmark"), for: .normal)
            selectedBrandArray.append(brandArray[indexPath.row])
            
        }
        else
        {
            sender.setImage(nil, for: .normal)
            print(indexPath.row)
            let index = selectedBrandArray.firstIndex(of: brandArray[indexPath.row])
            selectedBrandArray.remove(at: index!)
            print(index!)
            
        }
        print(selectedBrandArray)
        print(selectedBrandArray.count)
    }
}
