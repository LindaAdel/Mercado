//
//  ViewControllerExtension.swift
//  Mercado
//
//  Created by Dina ElShabassy on 6/6/21.
//

import Foundation
import UIKit

extension UIViewController {
    
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
    
    func checkConnectivity(){
        if !Connectivity.isConnectedToInternet{
            let noConnectionVC = self.storyboard?.instantiateViewController(identifier: "NoConnection") as! NoInternetConnectionViewController
            noConnectionVC.modalPresentationStyle = .fullScreen
            self.present(noConnectionVC, animated: true, completion: nil)
        }
    }
}
