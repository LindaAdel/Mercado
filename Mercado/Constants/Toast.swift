//
//  Toast.swift
//  Mercado
//
//  Created by Mayar Adel on 6/5/21.
//

import UIKit
extension UIViewController {

func showToast(message : String, font: UIFont) {

    let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-120, width: 200, height: 35))
    toastLabel.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.3764705882, blue: 0.2470588235, alpha: 1)
//    toastLabel.sizeToFit()
    toastLabel.textColor = UIColor.white
    toastLabel.font = font
    toastLabel.textAlignment = .center;
    toastLabel.text = message
    toastLabel.alpha = 1.0
    toastLabel.layer.cornerRadius = 10;
    toastLabel.clipsToBounds  =  true
    self.view.addSubview(toastLabel)
    UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
         toastLabel.alpha = 0.0
    }, completion: {(isCompleted) in
        toastLabel.removeFromSuperview()
    })
} }
