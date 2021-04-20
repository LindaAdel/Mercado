//
//  ViewController.swift
//  Mercado
//
//  Created by Linda adel on 4/16/21.
//

import UIKit
import GoogleSignIn
import Firebase
class LoginTableViewController: UITableViewController
{
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.presentingViewController=self
       
    }
    //sigin with email
    @IBAction func emailSignIn(_ sender: Any)
    {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { authResult, error in
                   if let error = error as NSError? {
                       switch AuthErrorCode(rawValue: error.code) {
                       case .operationNotAllowed:print("error")
                           break;
                         // Error: Indicates that email and password accounts are not enabled. Enable them in the Auth section of the Firebase console.
                       case .userDisabled:
                           print("error")
                               break;
                         // Error: The user account has been disabled by an administrator.
                       case .wrongPassword:
                         // Error: The password is invalid or the user does not have a password.
                           print("wrong pass")
                       
                               break;
                       case .invalidEmail:
                           print("wrong mail")
                               break;
                         // Error: Indicates the email address is malformed.
                       default:
                           print("Error: \(error.localizedDescription)")
                           print("mail not found")
                       }
                     } else {
                       print("User signs in successfully")
                       let userInfo = Auth.auth().currentUser
                       let email = userInfo?.email
                     }
               }
        
    }
    //sigin with google
    @IBAction func googleSignIn(_ sender: Any)
    {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    


}

