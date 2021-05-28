//
//  ExploreExtension+TableView.swift
//  Mercado
//
//  Created by Dina ElShabassy on 5/18/21.
//

import Foundation
import UIKit

extension ExploreTabBarController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subCatgeoryArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        tableView.layer.cornerRadius = 15
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = subCatgeoryArray[indexPath.row].subcategoryName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let itemsVC = self.storyboard?.instantiateViewController(withIdentifier: "CategoryItems") as! itemsTableViewController
        itemsVC.modalPresentationStyle = .fullScreen
        itemsVC.subCategoryObj = subCatgeoryArray[indexPath.row]
        itemsVC.categoryName = self.categoryName!
        itemsVC.itemcategoryName = self.itemcategoryName!
        print("from home \(categoriesArray[indexPath.row].categoryName)")
        print(categoriesArray[indexPath.row])
        self.present(itemsVC, animated: true, completion: nil)
       
        
    }
    
    
}

