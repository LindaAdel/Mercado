//
//  GetStartedViewController.swift
//  Mercado
//
//  Created by Dina ElShabassy on 4/22/21.
//

import UIKit

class GetStartedViewController: UIViewController {

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    @IBAction func getStartedBtn(_sender: UIButton)
    {
        //to open getstarted view only in the first time when the user using the app
        UserDefaults.standard.setValue(false, forKey: "getStarted")

        let loginView = self.storyboard?.instantiateViewController(withIdentifier: "login") as! LoginViewController
        loginView.modalPresentationStyle = .fullScreen
        self.present(loginView, animated: true, completion: nil)
    }


}
