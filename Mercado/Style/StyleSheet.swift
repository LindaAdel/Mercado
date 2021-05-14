//
//  StyleSheet.swift
//  Mercado
//
//  Created by Linda adel on 4/20/21.
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
  
        
}

