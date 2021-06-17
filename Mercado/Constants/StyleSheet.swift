//
//  StyleSheet.swift
//  Mercado
//
//  Created by Linda adel on 5/16/21.
//

import Foundation
import UIKit

class StyleSheet {
    
    static func styleTextField(_ textfield:UITextField) {
        
        // Create the bottom line
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)
       
            bottomLine.backgroundColor = UIColor.init(red: 226/255, green: 226/255, blue: 226/255, alpha: 1).cgColor
        
        // Remove border on text field
        textfield.borderStyle = .none
        
        // Add the line to the text field
        textfield.layer.addSublayer(bottomLine)
        
    }
static func showTextFieldError(placeholderValue:String)->NSAttributedString?
    {
        return NSAttributedString(string: placeholderValue, attributes: [
            .foregroundColor: UIColor.red,
            .font: UIFont.boldSystemFont(ofSize: 15.0),
        ])
    }
    static func styleHollowButton(_ button:UIButton) {
           
           // Hollow rounded corner style 
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.init(red: 83/255, green: 177/255, blue: 117/255, alpha: 1).cgColor
        button.layer.cornerRadius = 15.0
//           button.tintColor = UIColor.init(red: 226/255, green: 226/255, blue: 226/255, alpha: 1)
       }
    static func roundImage(_ image : UIImageView)
    {
        
        image.clipsToBounds = true
        image.layer.cornerRadius = (image.bounds.width)/2
    }

        
}


