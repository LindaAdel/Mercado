//
//  SignUpExtension.swift
//  Mercado
//
//  Created by Linda adel on 6/24/21.
//

import Foundation
import Firebase

extension SignUpTableViewController {
    
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
        
//        ErrorLabel.text = message
//        ErrorLabel.alpha = 1
    }
    func showToast(_ message:String)  {
        
//        ErrorLabel.textColor = UIColor.init(red: 83/255, green: 177/255, blue: 117/255, alpha: 1)
//        ErrorLabel.text = message
//        ErrorLabel.alpha = 1
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
            // self.showError("User already exist")
            self.E_mailTextField.showTextFieldError(placeholderValue: "User already exist")
            
             }
           else{
            
             let userID = Auth.auth().currentUser?.uid
             self.ref.child("users").child(userID! ).setValue(["username": userName])
            switch Auth.auth().currentUser?.isEmailVerified {
            case true:
                print("users email is verified")
               // self.showToast(" email is verified")
                break
            case false:
                
                Auth.auth().currentUser?.sendEmailVerification { (error) in
                    
                    guard let error = error else {
                        self.UserNameTextField.text = ""
                        self.E_mailTextField.text = ""
                        self.PasswordTextField.text = ""
                        let verifyAlert = UIAlertController(title: "Alert", message: "a verification mail was sent please verify your email address", preferredStyle: .alert)
                        verifyAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
                            self.natigateToHome()
                        }))
                        self.present(verifyAlert, animated: true, completion: nil)

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
//    func natigateToHome(){
//
//        Auth.auth().currentUser?.reload(completion: { (error) in
//
//            if let error = error {
//                print(error)
//            } else {
//                if Auth.auth().currentUser != nil && Auth.auth().currentUser!.isEmailVerified {
//                    if let HomeVC = self.storyboard?.instantiateViewController(withIdentifier: "Home") as? HomeTabBarController{
//                        HomeVC.modalPresentationStyle = .fullScreen
//                        self.present(HomeVC, animated: true, completion: nil)}
//
//                } else {
//
//                    print("Email is not verified please verifiy to continue Navigation")
//                    if let emailNotVerifiedVC = self.storyboard?.instantiateViewController(withIdentifier: "mailNotVerified") as? EmailNotVerifiedViewController{
//                        emailNotVerifiedVC.modalPresentationStyle = .fullScreen
//                        self.present(emailNotVerifiedVC, animated: true, completion: nil)}
//
//                }
//            }
//       })
//
//
//    }
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
            self.natigateToHome()
               
           }
           
       }

   
}
