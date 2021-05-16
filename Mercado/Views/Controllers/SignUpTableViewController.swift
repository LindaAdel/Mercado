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
        
        if let logInVC = self.storyboard?.instantiateViewController(withIdentifier: "login") as? LoginTableViewController{
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
    func addEmailCheckSign(image : UIImage){
        let emailCheckSign = UIImageView(frame: CGRect(x: CGFloat(E_mailTextField.frame.size.width - 25), y: CGFloat(5), width: CGFloat(15), height: CGFloat(25)))
        emailCheckSign.image = image
        emailCheckSign.alpha = 0
        E_mailTextField.rightView = emailCheckSign
        E_mailTextField.rightViewMode = .always
    
        
    }
    func setUpPasswordSecurityIcon()  {
        
        PasswordTextField.rightViewMode = .unlessEditing
               
        passwordVisibiltyButton.setImage(UIImage(named: "lock"), for: .normal)
        passwordVisibiltyButton.imageEdgeInsets = UIEdgeInsets(top: 5, left: -24, bottom: 5, right: 15)
        passwordVisibiltyButton.frame = CGRect(x: CGFloat(PasswordTextField.frame.size.width - 25), y: CGFloat(5), width: CGFloat(15), height: CGFloat(25))
        passwordVisibiltyButton.addTarget(self, action: #selector(self.passwordVisibiltyButtonClicked), for: .touchUpInside)
        PasswordTextField.rightView = passwordVisibiltyButton
        PasswordTextField.rightViewMode = .always
        
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
   
    //validate fields if correct return nill else return error message
    func validateFields() -> String? {
        //check if all fields are filled
        if UserNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || E_mailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            PasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "all fields are required to sign up"
        }
        // check password for validation checks
        let userPassword = PasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if isPasswordValid(userPassword) == false {
            return "Your password should contain at least 8 characters including numbers and speacial characters"
        }
        // check email for validation checks
        let userMail = E_mailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if isValidEmail(userMail) == false {
            return "Enter a valid email address to sign up "
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
    func showToast(_ message:String)  {
        
        ErrorLabel.textColor = UIColor.init(red: 83/255, green: 177/255, blue: 117/255, alpha: 1)
        ErrorLabel.text = message
        ErrorLabel.alpha = 1
    }
    func handleError(error: Error) {
            
            // the user is not registered
            // user not found
            
            let errorAuthStatus = AuthErrorCode.init(rawValue: error._code)!
            switch errorAuthStatus {
            case .wrongPassword:
                print("wrongPassword")
            case .invalidEmail:
                print("invalidEmail")
            case .operationNotAllowed:
                print("operationNotAllowed")
            case .userDisabled:
                print("userDisabled")
            case .userNotFound:
                print("userNotFound")
                self.register(auth: Auth.auth())
            case .tooManyRequests:
                print("tooManyRequests, oooops")
            default: fatalError("error not supported here")
            }
            
        }
    func register(auth: Auth) {
        // create clean version of data
        let userName = UserNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let userMail = E_mailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let userPassword = PasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        //there is no error than create user
        Auth.auth().createUser(withEmail: userMail , password: userPassword ) { [self] authResult, authError in
           // check for authError
           if authError != nil {
                 //there is an error
             self.showError("User already exist")
             }
           else{
            
             let userID = Auth.auth().currentUser?.uid
             self.ref.child("users").child(userID! ).setValue(["username": userName])
            switch Auth.auth().currentUser?.isEmailVerified {
            case true:
                print("users email is verified")
                self.showToast(" email is verified")
                break
            case false:
                
                Auth.auth().currentUser?.sendEmailVerification { (error) in
                    
                    guard let error = error else {
                        self.UserNameTextField.text = ""
                        self.E_mailTextField.text = ""
                        self.PasswordTextField.text = ""
                        let verifyAlert = UIAlertController(title: "Alert", message: "a verification mail was sent please verify your email address", preferredStyle: .alert)
                        verifyAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
                            natigateToHome()
                        }))
                        self.present(verifyAlert, animated: true, completion: nil)
                        showToast("a verification mail was sent please verify your email address")
                        return print("user email verification sent")
                    
                    
                    }
                    
                    self.handleError(error: error)
                }
                
                print("verify it now")
                break
            default: break
            }
            
           }
         }
    }
    func natigateToHome(){
        if let HomeVC = self.storyboard?.instantiateViewController(withIdentifier: "Home") as? HomeTabBarController{
             HomeVC.modalPresentationStyle = .fullScreen
             self.present(HomeVC, animated: true, completion: nil)}
    }
    func signin(auth: Auth) {
     
        let userMail = E_mailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let userPassword = PasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
           
           auth.signIn(withEmail: userMail, password: userPassword) { (result, error) in
               
               guard error == nil else {
                   return self.handleError(error: error!)
               }
               
               guard let user = result?.user else{
                   fatalError("Not user do not know what went wrong")
               }
               
            print("Signed in user: \(String(describing: user.email))")
               
           }
           
       }

   
}

