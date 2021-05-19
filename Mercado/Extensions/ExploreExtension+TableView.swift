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
        
        tableView.layer.cornerRadius = 7
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = subCatgeoryArray[indexPath.row].subcategoryName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "getStarted") as! GetStartedViewController
        vc.modalPresentationStyle = .fullScreen
        vc.subCategoryObj = subCatgeoryArray[indexPath.row]
        self.navigationController!.pushViewController(vc, animated: true)
        
    }
    
}
