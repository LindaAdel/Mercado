//
//  CartTableViewExtension.swift
//  Mercado
//
//  Created by Mayar Adel on 5/31/21.
//

import UIKit

extension CartViewController : UITableViewDelegate,UITableViewDataSource
{
    
    //MARK:- Tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemsArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cartCell = tableView.dequeueReusableCell(withIdentifier: String(describing : CartTableViewCell.self), for: indexPath) as!CartTableViewCell
        
        
        cartCell.itemTitle.text = itemsArray[indexPath.row].item_title!
        cartCell.itemPrice.text = "\(itemsArray[indexPath.row].item_price!) EGP"
        cartCell.itemImage.sd_setImage(with: URL(string: itemsArray[indexPath.row].item_image!), completed: nil)
        
        //set current cart
        if indexPath.row < cartItemsArray.count
        {
            cartCell.currentCartId = String(cartItemsArray[indexPath.row].itemId!)
            cartCell.quantityValue = cartItemsArray[indexPath.row].count!
            cartCell.quantityLabel.text = String(cartItemsArray[indexPath.row].count!)
        }
        print("cell reloaded")
        cartCell.contentView.layer.shadowOpacity = 0.5
        return cartCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
    -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { [self] (_, _, completionHandler) in
            // delete the item here
            print("remove cart \(self.cartItemsArray.count)")
            print("remove items \(self.itemsArray.count)")
            self.itemsArray.remove(at: indexPath.row)
            // Delete the row from tableview
            tableView.deleteRows(at: [indexPath], with: .fade)
            cartViewModel.removeCartItemFromFirebase(itemId: self.cartItemsArray[indexPath.row].itemId!)
            
            cartItemsArray.remove(at: indexPath.row)
            print("remove cart \(cartItemsArray.count)")
            print("remove items \(itemsArray.count)")
           
            if(itemsArray.count == 0)
            {
                cartTabBarIcon.badgeValue = nil
                print("show image from delete")
                self.updateEmptyCartUI()
            }
            else{
                cartTabBarIcon.badgeValue = String(itemsArray.count)
            cartViewModel.getCartItems()
            }
           // print("will \(itemsArray.count)")
            completionHandler(true)
        }
        let image = UIImage(systemName: "trash")?.colored(in: #colorLiteral(red: 0.3254901961, green: 0.6941176471, blue: 0.4588235294, alpha: 1))
        deleteAction.image = image
        deleteAction.backgroundColor = .white
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
    //navigate to details screen
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = storyboard?.instantiateViewController(withIdentifier: "productDetails") as! ProductDetailsViewController
        detailsVC.categoryName = cartItemsArray[indexPath.row].category
        print(cartItemsArray[indexPath.row].itemId!)
        detailsVC.itemDetails = itemsArray[indexPath.row]
        detailsVC.itemDetails.item_id = cartItemsArray[indexPath.row].itemId!
        detailsVC.subCategoryName = cartItemsArray[indexPath.row].subCategory
        detailsVC.modalPresentationStyle = .fullScreen
        self.present(detailsVC, animated: true, completion: nil)
    }
}
