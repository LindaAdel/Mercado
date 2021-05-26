//
//  Alert.swift
//  Mercado
//
//  Created by Mayar Adel on 5/22/21.
//

import Foundation
import UIKit
struct Alert {
    func showAlert(alertTitle:String?,alertMessage:String?,alertActionOne:UIAlertAction?,alertActionTwo :UIAlertAction?,Self:UIViewController?)
    {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        if let firstAction = alertActionOne
        {
            alert.addAction(firstAction)
            print("fires")
        }
        if let secAction = alertActionTwo
        {
            alert.addAction(secAction)
        }
        
        Self!.present(alert, animated: true, completion: nil)
    }
    func addAlertAction(alertActionTitle:String?,titleColor:UIColor,alertActionStyle:UIAlertAction.Style,alertActionhandler: ((UIAlertAction)->Void)?)->UIAlertAction  {
        //handler: ((UIAlertAction) -> Void)?
       let alertAction = UIAlertAction(title:alertActionTitle, style: alertActionStyle, handler:alertActionhandler)
        alertAction.setValue(titleColor, forKey: "titleTextColor")
        return alertAction
    }
}
