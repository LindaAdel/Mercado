//
//  ViewController.swift
//  Mercado
//
//  Created by Linda adel on 4/16/21.
//

import UIKit
import GoogleSignIn
class LoginTableViewController: UITableViewController
{
    @IBOutlet var googleSignIn:GIDSignInButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.presentingViewController=self
       
    }


}

