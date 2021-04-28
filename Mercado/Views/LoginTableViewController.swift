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

    @IBOutlet weak var showPasswordButton: UIButton!
    
    @IBAction func showPasswordButton(_ sender: Any)
    {
        if !passwordTextField.text!.isEmpty
        {
          passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
        //check if user show password
        if(!passwordTextField.isSecureTextEntry)
        {
            showPasswordButton.setImage(UIImage(named: "showPassword"),for: .normal)
        }
        //hide password
        else
        {
            showPasswordButton.setImage(UIImage(named: "securePassword"),for: .normal)
        }
        }
    }
    //    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator)
//    {
//        print(self.tableView.frame.height)
//        print(UIScreen.main.fixedCoordinateSpace.bounds.height)
//        if (self.tableView.frame.height >= UIScreen.main.fixedCoordinateSpace.bounds.height) {
//            print("bigger")
//            self.tableView.isScrollEnabled = true;
//         }
//        else {
//            print("smaller")
//            self.tableView.isScrollEnabled = false;
//         }
//    }
    
    @IBAction func forgotPasswordButton(_ sender: Any)
    {
        
        Auth.auth().sendPasswordReset(withEmail: emailTextField.text!, completion: { (error) in
                    if error != nil{
                        print("\(String(describing: error!.localizedDescription) )")
                        let resetFailedAlert = UIAlertController(title: "Reset Failed", message: "\( String(describing: error!.localizedDescription))", preferredStyle: .alert)
                        resetFailedAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(resetFailedAlert, animated: true, completion: nil)
                    }else {
                        let resetEmailSentAlert = UIAlertController(title: "Reset email sent successfully", message: "Check your email", preferredStyle: .alert)
                        resetEmailSentAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(resetEmailSentAlert, animated: true, completion: nil)
                    }
                })
    }
    @IBAction func signupButton(_ sender: Any)
    {
        
        let signUpView = self.storyboard?.instantiateViewController(withIdentifier: "signup") as! SignUpTableViewController
        signUpView.modalPresentationStyle = .fullScreen
        self.present(signUpView, animated: true, completion: nil)
    }
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad()
    {
        super.viewDidLoad()
       GIDSignIn.sharedInstance()?.presentingViewController=self
        GIDSignIn.sharedInstance().delegate = self
        print(Auth.auth().currentUser?.email!)
        
        //self.tableView.alwaysBounceVertical=false
//        self.tableView.isScrollEnabled = self.tableView.contentSize.height > self.tableView.frame.size.height;
       
        //add padding to the textfields
        emailTextField.layer.sublayerTransform = CATransform3DMakeTranslation(7, 0, 0)
        passwordTextField.layer.sublayerTransform = CATransform3DMakeTranslation(7, 0, 0)
       
//        passwordTextField.rightView = UIImageView(image: UIImage(named: "vision"))
//        passwordTextField.rightViewMode = .always
       
    }
   
    //sigin with email
    @IBAction func emailSignIn(_ sender: Any)
    {
        if ((passwordTextField.text!.isEmpty) &&  (emailTextField.text!.isEmpty  ) )
        {
            print("emty fields")
            self.passwordTextField.attributedPlaceholder = NSAttributedString(string: "required!", attributes: [
                .foregroundColor: UIColor.red,
                .font: UIFont.boldSystemFont(ofSize: 15.0),
            ])
            self.emailTextField.attributedPlaceholder = NSAttributedString(string: "required!", attributes: [
                .foregroundColor: UIColor.red,
                .font: UIFont.boldSystemFont(ofSize: 15.0),
            ])
        }
        else{
        if (passwordTextField.text!.isEmpty){
            print("emty pass")
            self.passwordTextField.text?.removeAll()
            self.passwordTextField.attributedPlaceholder = NSAttributedString(string: "required!", attributes: [
                .foregroundColor: UIColor.red,
                .font: UIFont.boldSystemFont(ofSize: 15.0),
            ])
            return
        }
        if (emailTextField.text!.isEmpty )
        {
            print("empty maill")
            self.emailTextField.text?.removeAll()
            self.emailTextField.attributedPlaceholder = NSAttributedString(string: "required!", attributes: [
                .foregroundColor: UIColor.red,
                .font: UIFont.boldSystemFont(ofSize: 15.0),
            ])
            return
        }
        else{
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { authResult, error in
                   if let error = error as NSError? {
                    let er = AuthErrorCode(rawValue: error.code)
                   
                       switch AuthErrorCode(rawValue: error.code)
                       {
                       case .operationNotAllowed:print("error")
                          // break;
                         // Error: Indicates that email and password accounts are not enabled. Enable them in the Auth section of the Firebase console.
                       case .userDisabled:
                           print("error")
                          //     break;
                         // Error: The user account has been disabled by an administrator.
                       
                       case.userNotFound:print("not found")
                        self.emailTextField.text?.removeAll()
                        self.emailTextField.attributedPlaceholder = NSAttributedString(string: "Email not found!", attributes: [
                            .foregroundColor: UIColor.red,
                            .font: UIFont.boldSystemFont(ofSize: 15.0),
                        ])
                       case .wrongPassword:
                         // Error: The password is invalid or the user does not have a password.
                           print("wrong pass")
//                        if ((self.passwordTextField.text?.isEmpty) != nil)
//                        {
//                            print("empty")
//                         //   break;
//                        }
//                        else{
                        self.passwordTextField.text?.removeAll()
                        self.passwordTextField.attributedPlaceholder = NSAttributedString(string: "Incorrect Password!", attributes: [
                            .foregroundColor: UIColor.red,
                            .font: UIFont.boldSystemFont(ofSize: 15.0),
                        ])
                          //  break;
               //dd         }
                       
                      
                              // break;
                         // Error: Indicates the email address is malformed.
                       default:
                           print("Error: \(error.localizedDescription)")
                           print("Email not found")
                        self.emailTextField.text?.removeAll()
                        self.emailTextField.attributedPlaceholder = NSAttributedString(string: "Invalid Email!", attributes: [
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

