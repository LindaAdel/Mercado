//
//  SignUpTableViewController.swift
//  Mercado
//
//  Created by Linda adel on 4/20/21.
//

import UIKit
import Firebase


class SignUpTableViewController: UITableViewController {

    @IBOutlet weak var UserNameTextField: UITextField!
    
    @IBOutlet weak var E_mailTextField: UITextField!
    
    @IBOutlet weak var PasswordTextField: UITextField!
    
    @IBOutlet weak var ErrorLabel: UILabel!
    
    
    @IBOutlet weak var SignUpButton: UIButton!
    
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // hide error label
        ErrorLabel.alpha = 0
        
    }
    @IBAction func navigateToLogIn(_ sender: Any) {
        
        if let logInVC = self.storyboard?.instantiateViewController(withIdentifier: "login") as? LoginTableViewController{
            logInVC.modalTransitionStyle = .flipHorizontal
            logInVC.modalPresentationStyle = .fullScreen
            self.present(logInVC, animated: true, completion: nil)}
    }
    @IBAction func SignUpTapped(_ sender: Any) {
        //validate fields
        let  error = validateFields()
        if error != nil{
            //there is an error
           showError(error!)
        }
        else {
            // create clean version of data
            let userName = UserNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let userMail = E_mailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let userPassword = PasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
          
            //there is no error than create user
           
            Auth.auth().createUser(withEmail: userMail , password: userPassword ) { authResult, authError in
              // check for authError
              if authError != nil {
                    //there is an error
                self.showError("USER ALREADY EXISTE")
                }
              else{
                // user is created successfully & storing user data
                let db = Firestore.firestore()
                db.collection("users").addDocument(data: ["username":userName,"uid":authResult!.user.uid ]) {(error) in
                    if error != nil{
                        //show error method
                        self.showError("COULD NOT SAVE YOUR USERNAME")
                    }
                }
              }
            }
        }
        UserNameTextField.text = ""
        E_mailTextField.text = ""
        PasswordTextField.text = ""
    }
    //validate fields if correct return nill else return error message
    func validateFields() -> String? {
        //check if all fields are filled
        if UserNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || E_mailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            PasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "PLEASE MAKE SURE ALL FIELDS ARE FILLED"
        }
        // check password for validation checks
        let userPassword = PasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if isPasswordValid(userPassword) == false {
            return "PLEASE MAKE SURE YOUR PASSWORD CONTAIN AT LEAST 8 CHARACTERS , CONTAINS SPEACIAL CHARACTER AND NUMBER"
        }
        // check email for validation checks
        let userMail = E_mailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if isValidEmail(userMail) == false {
            return "PLEASE MAKE SURE YOUR EMAIL IS WRITTEN CORRECTLY"
        }
        
        return nil
    }
    //8 character contain num,alpha,specialcharacter
    func isPasswordValid(_ password : String) -> Bool{
        let passwordCheck = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordCheck.evaluate(with: password)
    }
    // EMAIL syntacs validation
    func isValidEmail(_ email:String) -> Bool {
      
      //  let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        //let emailRegex = "(\W|^)[\w.\-]{0,25}@(yahoo|hotmail|gmail)\.com(\W|$)"
        let emailRegex = "[A-Z0-9a-z._%+-]+@(yahoo|hotmail|gmail)+\\.com"
        let emailCheck = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailCheck.evaluate(with: email)
      
    }
    func showError(_ message:String){
        
        ErrorLabel.text = message
        ErrorLabel.alpha = 1
    }

   
}
