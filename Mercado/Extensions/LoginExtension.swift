//
//  LoginExtension.swift
//  Mercado
//
//  Created by Mayar Adel on 4/29/21.
//

import Foundation
import UIKit
import GoogleSignIn
import Firebase
extension LoginTableViewController
{
    func showAndHidePasswordIcon()
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
    //alert dialog
    func showAlert(title:String,message:String){
        let resetFailedAlert = UIAlertController(title: title, message: "\( String(describing: message))", preferredStyle: .alert)
        resetFailedAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(resetFailedAlert, animated: true, completion: nil)
    }
//firebase resetpassword
func firebaseResetPassword()
{
    Auth.auth().sendPasswordReset(withEmail: emailTextField.text!, completion: { (error) in
                if error != nil{
                    print("\(String(describing: error!.localizedDescription) )")
                    //display alert with error message
                    self.showAlert(title: "Reset Failed",message: error!.localizedDescription)
                    
                }else {
                    //display error with successfull message
                    self.showAlert(title:"Reset email sent successfully",message: "Check your email")
                }
            })
 }
    //handle google signin process
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?)
    {

        guard let authentication = user?.authentication else { print("err"); return }
              let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,accessToken: authentication.accessToken)
               Auth.auth().signIn(with: credential) { (authResult, error) in
               if let error = error {
               print(error.localizedDescription)
               } else {
               print("Login Successful.")
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "Home") as! HomeTabBarController
                self.present(vc, animated: true, completion: nil)
               
               }
           
        }

    }
   
    //firebase login handling
    func firebaseLogin()
    {
        //check empty fields
        if ((passwordTextField.text!.isEmpty) &&  (emailTextField.text!.isEmpty  ) )
        {

            self.passwordTextField.attributedPlaceholder =  TextFieldErrors().showTextFieldError(placeholderValue: "required!")
            self.emailTextField.attributedPlaceholder = TextFieldErrors().showTextFieldError(placeholderValue: "required!")
        }
        else{
        if (passwordTextField.text!.isEmpty){
            print("emty pass")
            self.passwordTextField.text?.removeAll()
            self.passwordTextField.attributedPlaceholder = TextFieldErrors().showTextFieldError(placeholderValue: "required!")
            return
        }
        if (emailTextField.text!.isEmpty )
        {
            print("empty maill")
            self.emailTextField.text?.removeAll()
            self.emailTextField.attributedPlaceholder = TextFieldErrors().showTextFieldError(placeholderValue: "required!")
            return
        }
        else{
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { authResult, error in
                   if let error = error as NSError? {

                       switch AuthErrorCode(rawValue: error.code)
                       {
                         //check if email not found in firebase
                       case.userNotFound:
                        self.emailTextField.text?.removeAll()
                        self.emailTextField.attributedPlaceholder =
                            TextFieldErrors().showTextFieldError(placeholderValue:  "Email not found!")
                       //incorrect password
                       case .wrongPassword:
                           print("wrong pass")
                        self.passwordTextField.text?.removeAll()
                        self.passwordTextField.attributedPlaceholder =
                            TextFieldErrors().showTextFieldError(placeholderValue:  "Incorrect Password!")

                       default:
//                           print("Error: \(error.localizedDescription)")
//                           print("Email not found")
                        self.emailTextField.text?.removeAll()
                        self.emailTextField.attributedPlaceholder =
                            TextFieldErrors().showTextFieldError(placeholderValue: "Invalid Email!")
                        
                       }
                     } else {
                       print("User signs in successfully")
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Home") as! HomeTabBarController
                        self.present(vc, animated: true, completion: nil)
                      // let userInfo = Auth.auth().currentUser
                    //   let email = userInfo?.email
                     }
               }
        }
        }
    }
}
