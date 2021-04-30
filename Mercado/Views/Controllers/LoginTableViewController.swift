//
//  ViewController.swift
//  Mercado
//
//  Created by Linda adel on 4/16/21.
//

import UIKit
import GoogleSignIn

class LoginTableViewController: UITableViewController,GIDSignInDelegate
{

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var showPasswordButton: UIButton!
    @IBAction func showPasswordButton(_ sender: Any)
    {
        self.showAndHidePasswordIcon()
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
        
        self.firebaseResetPassword()
    }
    @IBAction func signupButton(_ sender: Any)
    {
        
        let signUpView = self.storyboard?.instantiateViewController(withIdentifier: "signup") as! SignUpTableViewController
        signUpView.modalPresentationStyle = .fullScreen
        self.present(signUpView, animated: true, completion: nil)
    }
    
 
    override func viewDidLoad()
    {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.presentingViewController=self
        GIDSignIn.sharedInstance().delegate = self
     //   print(Auth.auth().currentUser?.email!)
        
        //self.tableView.alwaysBounceVertical=false
//        self.tableView.isScrollEnabled = self.tableView.contentSize.height > self.tableView.frame.size.height;
       
        //add padding to the textfields
        emailTextField.layer.sublayerTransform = CATransform3DMakeTranslation(7, 0, 0)
        passwordTextField.layer.sublayerTransform = CATransform3DMakeTranslation(7, 0, 0)
       
       
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

