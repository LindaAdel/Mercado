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
                self.showError("ERROR CREATING USER")
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
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailCheck = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailCheck.evaluate(with: email)
      
    }
    func showError(_ message:String){
        
        ErrorLabel.text = message
        ErrorLabel.alpha = 1
    }

   
}
