//
//  ViewController.swift
//  Mercado
//
//  Created by Linda adel on 4/16/21.
//

import UIKit
import GoogleSignIn

class LoginViewController: UIViewController,GIDSignInDelegate, UIScrollViewDelegate
{
 
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    var showPasswordButton: UIButton!
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if scrollView.contentOffset.x != 0 {
//                   scrollView.contentOffset.x = 0
//               }
//    }
     override func viewDidLoad()
     {
         super.viewDidLoad()
      
        scrollView
            .delegate = self
        
         GIDSignIn.sharedInstance()?.presentingViewController=self
         GIDSignIn.sharedInstance().delegate = self
         self.scrollView.contentOffset.x = 0
        self.addEyeButtonToPassword()
        
       //  emailTextField.addBottomBorder(color: self.view.tintColor)
         //emailTextField.placeholder = "Email"
       //  passwordTextField.addBottomBorder(color: self.view.tintColor)
        // passwordTextField.placeholder = "Password"
         //add padding to the textfields
         emailTextField.layer.sublayerTransform = CATransform3DMakeTranslation(7, 0, 0)
         passwordTextField.layer.sublayerTransform = CATransform3DMakeTranslation(7, 0, 0)
        setUpElements()
        
     }
    func setUpElements()  {
     
        // style text field
        StyleSheet.styleTextField(emailTextField)
        StyleSheet.styleTextField(passwordTextField)
       
    }
 
    
    @IBAction func forgotPasswordButton(_ sender: Any)
    {
        
        self.firebaseResetPassword()
    }
    @IBAction func signupButton(_ sender: Any)
    {
        
        let signUpView = self.storyboard?.instantiateViewController(withIdentifier: "signup") as! SignUpTableViewController
        signUpView.modalPresentationStyle = .fullScreen
        self.present(signUpView, animated: true, completion: nil)
    }

   
    //sigin with email
    @IBAction func emailSignIn(_ sender: Any)
    {

        self.firebaseLogin()
    }
    //sigin with google button
    @IBAction func googleSignIn(_ sender: Any)
    {
        GIDSignIn.sharedInstance()?.signIn()
        
    }
    
    
  
}

