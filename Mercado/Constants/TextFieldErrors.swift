//
//  TextFieldErrors.swift
//  Mercado
//
//  Created by Mayar Adel on 4/29/21.
//

import Foundation
import UIKit


extension UITextField {
    func addBottomBorder(color: UIColor){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width-15, height: 1)
        bottomLine.backgroundColor = color.cgColor
        borderStyle = .none
        layer.addSublayer(bottomLine)
    }
    func showTextFieldError(placeholderValue:String)
    {
        self.attributedPlaceholder = NSAttributedString(string: placeholderValue, attributes: [
            .foregroundColor: UIColor.red,
            .font: UIFont.boldSystemFont(ofSize: 15.0),
        ])
    }
    func isEmptyField() -> Bool{
        if self.text!.isEmpty
        {
            showTextFieldError(placeholderValue: "required")
            return true
        }
        else
        {
            return false
        }
        
    }
}
