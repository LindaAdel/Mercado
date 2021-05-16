//
//  TextFieldErrors.swift
//  Mercado
//
//  Created by Mayar Adel on 4/29/21.
//

import Foundation
import UIKit
struct TextFieldErrors
{

    
    func showTextFieldError(placeholderValue:String)->NSAttributedString?
    {
        return NSAttributedString(string: placeholderValue, attributes: [
            .foregroundColor: UIColor.red,
            .font: UIFont.boldSystemFont(ofSize: 15.0),
        ])
    }
}
