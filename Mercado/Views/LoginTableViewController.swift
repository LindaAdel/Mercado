//
//  ViewController.swift
//  Mercado
//
//  Created by Linda adel on 4/16/21.
//

import UIKit
import GoogleSignIn
import Firebase
class LoginTableViewController: UITableViewController,GIDSignInDelegate
{
    @IBAction func signupButton(_ sender: Any)
    {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "signup") as! SignUpTableViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.presentingViewController=self
        GIDSignIn.sharedInstance().delegate = self
        print(Auth.auth().currentUser?.email!)
       
        //add padding to the textfields
        emailTextField.layer.sublayerTransform = CATransform3DMakeTranslation(7, 0, 0)
        passwordTextField.layer.sublayerTransform = CATransform3DMakeTranslation(7, 0, 0)
       
        
       
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
                        self.passwordTextField.text?.removeAll()
                        self.passwordTextField.attributedPlaceholder = NSAttributedString(string: "Wrong Password!", attributes: [
                            .foregroundColor: UIColor.red,
                            .font: UIFont.boldSystemFont(ofSize: 15.0),
                        ])
                              
                               break;
                       case .invalidEmail:
                           print("wrong mail")
                        
                               break;
                         // Error: Indicates the email address is malformed.
                       default:
                           print("Error: \(error.localizedDescription)")
                           print("mail not found")
                        self.emailTextField.text?.removeAll()
                        self.emailTextField.attributedPlaceholder = NSAttributedString(string: "not found!", attributes: [
                            .foregroundColor: UIColor.red,
                            .font: UIFont.boldSystemFont(ofSize: 15.0),
                        ])
                       }
                     } else {
                       print("User signs in successfully")
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "first") as! ViewController
                        self.present(vc, animated: true, completion: nil)
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
    
    
    //handle google signin process
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?)
    {

            guard let authentication = user.authentication else { return }
              let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,accessToken: authentication.accessToken)
               Auth.auth().signIn(with: credential) { (authResult, error) in
               if let error = error {
               print(error.localizedDescription)
               } else {
               print("Login Successful.")
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "first") as! ViewController
                self.present(vc, animated: true, completion: nil)
               
               }
           
        }

    }

}

