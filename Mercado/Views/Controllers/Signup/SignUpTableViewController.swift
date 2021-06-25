//
//  SignUpTableViewController.swift
//  Mercado
//
//  Created by Linda adel on 4/20/21.
//

import UIKit
import Firebase


class SignUpTableViewController: UITableViewController {
    
    var ref : DatabaseReference! = Database.database().reference()
   
    @IBOutlet weak var UserNameTextField: UITextField!
    
    @IBOutlet weak var E_mailTextField: UITextField!
    
    @IBOutlet weak var PasswordTextField: UITextField!
    
    @IBOutlet weak var ErrorLabel: UILabel!
    
    
    @IBOutlet weak var SignUpButton: UIButton!
    
    let passwordVisibiltyButton = UIButton(type: .custom)
    var passwordVisibiltyButtonColor = UIButton(type: .custom)
    
    let emailCheckMark = UIImage(named: "CheckMark")
   
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
       setUpElements()
       setUpPasswordSecurityIcon()
      addEmailCheckSign(image: emailCheckMark!)
       
    }
    @IBAction func navigateToLogIn(_ sender: Any) {
        
        if let logInVC = self.storyboard?.instantiateViewController(withIdentifier: "login") as? LoginViewController{
            logInVC.modalPresentationStyle = .fullScreen
            self.present(logInVC, animated: true, completion: nil)}
    }
    @IBAction func SignUpTapped(_ sender: Any) {
        //validate fields
        let  error = validateFields()
        if error != nil{
            //there is an error
          // showError(error!)
            
            if error == "all fields are required to sign up"{
                if UserNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
                {self.UserNameTextField.showTextFieldError(placeholderValue: "required")}
                if E_mailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
                { self.E_mailTextField.showTextFieldError(placeholderValue: "required")}
                if PasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
                { self.PasswordTextField.showTextFieldError(placeholderValue: "required")}}
            if error == "Your password should contain at least 8 characters including numbers and speacial characters"{

                    self.PasswordTextField.text?.removeAll()
                    self.PasswordTextField.showTextFieldError(placeholderValue: "8 characters with numbers and characters")
               
              
            }
            if error == "Enter a valid email address to sign up "{
                self.E_mailTextField.text?.removeAll()
                self.E_mailTextField.showTextFieldError(placeholderValue:"Email must be valid")
                print("oooooooooo")
            }
          
            
        }
        else {
            guard let user = Auth.auth().currentUser else {
                      return self.signin(auth: Auth.auth())
                   }
                   
                   user.reload { (error) in
                      
                   }
         
        }
      
   
    }
    func setUpElements()  {
        // hide error label
        ErrorLabel.alpha = 0
        // style text field
        StyleSheet.styleTextField(UserNameTextField)
        StyleSheet.styleTextField(E_mailTextField)
        StyleSheet.styleTextField(PasswordTextField)
       
    }

    @IBAction func passwordVisibiltyButtonClicked(_ sender: Any) {
        
           (sender as! UIButton).isSelected = !(sender as! UIButton).isSelected
           if (sender as! UIButton).isSelected {
               self.PasswordTextField.isSecureTextEntry = false
            passwordVisibiltyButton.setImage(UIImage(named: "unlock"), for: .normal)
           } else {
               self.PasswordTextField.isSecureTextEntry = true
            passwordVisibiltyButton.setImage(UIImage(named: "lock"), for: .normal)
           }
       }
   

}

