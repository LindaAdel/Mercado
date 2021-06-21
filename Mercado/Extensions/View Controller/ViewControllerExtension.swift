//
//  ViewControllerExtension.swift
//  Mercado
//
//  Created by Dina ElShabassy on 6/6/21.
//

import Foundation
import UIKit

extension UIViewController {
    
    @objc func presentNoConnectionVC(_ notification : Notification) {
        if let data = notification.userInfo{
         let isConnected : Bool = data["isConnected"]! as! Bool
         if isConnected{
             DispatchQueue.main.async {
                 self.dismiss(animated: true, completion: nil)
             }
         }
         else{
             DispatchQueue.main.async {
                 let noConnectionVC = self.storyboard?.instantiateViewController(identifier: "NoConnection") as! NoInternetConnectionViewController
             noConnectionVC.modalPresentationStyle = .fullScreen
             self.present(noConnectionVC, animated: true, completion: nil)
             }
         }
      }
    }
    
    func showLoading(activityIndicator : UIActivityIndicatorView) {
           
           activityIndicator.hidesWhenStopped = true
           activityIndicator.center = self.view.center
           self.view.addSubview(activityIndicator)
           activityIndicator.startAnimating()
           
       }
       
       func hideLoading(activityIndicator : UIActivityIndicatorView) {
            DispatchQueue.main.async {
                activityIndicator.stopAnimating()
            }
           
       }
}
