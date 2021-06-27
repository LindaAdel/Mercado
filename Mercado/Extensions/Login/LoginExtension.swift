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
class PasswordTextField: UITextField {

    override var isSecureTextEntry: Bool {
        didSet {
            if isFirstResponder {
                _ = becomeFirstResponder()
            }
        }
    }

    override func becomeFirstResponder() -> Bool {

        let success = super.becomeFirstResponder()
        if isSecureTextEntry, let text = self.text {
            self.text?.removeAll()
            insertText(text)
        }
        return success
    }

}
extension  LoginViewController
{
    //MARK:- Eye Button
    func addEyeButtonToPassword()
    {
        passwordTextField.rightViewMode = .always
        showPasswordButton = UIButton()

        let image = UIImage(systemName: "eye.slash" )
        showPasswordButton.imageEdgeInsets = UIEdgeInsets(top: 5, left: -24, bottom: 5, right: 15)
        showPasswordButton.setImage(image, for: .normal)
        passwordTextField.rightView = showPasswordButton
        showPasswordButton.addTarget(self, action: #selector(showAndHidePasswordIcon), for: .touchUpInside)
       
    }
    @objc func showAndHidePasswordIcon()
    {
       
        if !passwordTextField.text!.isEmpty
        {
           
          passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
            
        //check if user show password
        if(!passwordTextField.isSecureTextEntry)
        {
            
            showPasswordButton.setImage(UIImage(systemName: "eye"),for: .normal)
        }
        //hide password
        else
        {

           
            showPasswordButton.setImage(UIImage(systemName: "eye.slash"),for: .normal)
        }
        }

    }

//firebase resetpassword
func firebaseResetPassword()
{
    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    Auth.auth().sendPasswordReset(withEmail: emailTextField.text!, completion: { (error) in
                if error != nil{
                    print("\(String(describing: error!.localizedDescription) )")
                    //display alert with error message
                    Alert().showAlert(alertTitle: "Reset Failed", alertMessage: error!.localizedDescription, alertActionOne: okAction, alertActionTwo: nil, Self: self)
                    
                }else {
                    //display error with successfull message
                    Alert().showAlert(alertTitle: "Reset email sent successfully", alertMessage: "Check your email", alertActionOne: okAction, alertActionTwo: nil, Self: self)
                    
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
          
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "Home") as! HomeTabBarController
                vc.modalPresentationStyle = .fullScreen
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
              
            self.passwordTextField.showTextFieldError(placeholderValue: "required!")
            self.emailTextField.showTextFieldError(placeholderValue: "required!")
       
        }
        else{
        if (passwordTextField.text!.isEmpty){
         
            self.passwordTextField.text?.removeAll()
            self.passwordTextField.showTextFieldError(placeholderValue: "required!")
            return
        }
        if (emailTextField.text!.isEmpty )
        {
           
            self.emailTextField.text?.removeAll()
            self.emailTextField.showTextFieldError(placeholderValue: "required!")
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
                        self.emailTextField.showTextFieldError(placeholderValue:  "Email not found!")
                       //incorrect password
                       case .wrongPassword:
                           print("wrong pass")
                        self.passwordTextField.text?.removeAll()
                        self.passwordTextField.showTextFieldError(placeholderValue:  "Incorrect Password!")

                       default:

                        self.emailTextField.text?.removeAll()
                        self.emailTextField.showTextFieldError(placeholderValue: "Invalid Email!")
                        
                       }
                     } else {
                      
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Home") as! HomeTabBarController
                            vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true, completion: nil)

                     }
               }
        }
        }
    }
}
