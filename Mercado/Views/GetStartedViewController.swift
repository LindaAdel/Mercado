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

        let loginView = self.storyboard?.instantiateViewController(withIdentifier: "login") as! LoginTableViewController
        loginView.modalPresentationStyle = .fullScreen
        self.present(loginView, animated: true, completion: nil)
    }


}
