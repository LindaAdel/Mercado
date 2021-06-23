//
//  MyAccountDetailsViewController.swift
//  Mercado
//
//  Created by Linda adel on 6/17/21.
//

import UIKit
import FirebaseAuth
import SDWebImage
import Firebase

class MyAccountDetailsViewController: UIViewController {

    @IBOutlet weak var cameraIcon: UIButton!
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var AccountCurvedView: UIView!
    
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userPassword: UILabel!
    
    var accountViewModel : AccountViewModel!
    var firebaseManger : FirebaseManager!
    var googoleUserPhotoChanged :Bool! = false
    
    override func viewWillAppear(_ animated: Bool) {
        checkConnectivity()
        accountViewModel.getUploadedImageFromFB()
        accountViewModel.getgetCurrentUserFromFB()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cameraIcon.layer.cornerRadius = cameraIcon.frame.width / 2
        cameraIcon.layer.borderWidth = 1
        cameraIcon.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        
        
        self.showCurvedView()
        StyleSheet.roundImage(userProfileImage)
        firebaseManger = FirebaseManager.shared
        accountViewModel = AccountViewModel()
        
    accountViewModel.bindUploadedImageToAccountVIew =
    {
        (img) in
        if let img = img
        {
            let url = URL(string: img)
        DispatchQueue.main.async {
            print("url \(String(describing: url))")
            self.googoleUserPhotoChanged = true
        self.userProfileImage.sd_setImage(with: url, placeholderImage: UIImage(systemName: "person.circle"), completed: nil)
        }
        }

    }
    accountViewModel.bindUserNameToAccountView =
    {
        (userName,user) in
        DispatchQueue.main.async {
           self.userName.text = userName
            print("done")
            self.userEmail.text = user?.email!
            if let googleAccountDisplayName = user?.displayName
            {
                self.userName.text = googleAccountDisplayName
            }
            if let image = user?.photoURL
            {
                if self.googoleUserPhotoChanged == false
                {
                self.userProfileImage.sd_setImage(with: image, placeholderImage: UIImage(systemName: "person.circle"), completed: nil)
                    print(self.googoleUserPhotoChanged!)
                }
            }
         
            
       }
    }

 
    }
    

    @IBAction func backNavButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func userNameEditTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Edit Your username", message: "Enter your New username", preferredStyle: .alert)

        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.text = ""
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak alert] (_) in
            let TextField = alert?.textFields![0]
            let newUsername = TextField?.text
            self.firebaseManger.updateUserName(newUsername!)
            self.userName.text = newUsername
            print("Text field: \(String(describing: newUsername))")
        }))

        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func userEmailEditTapped(_ sender: Any) {
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Edit Your Email Address", message: "Enter your New Email", preferredStyle: .alert)

        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (passwordTextField) in
            passwordTextField.text = ""
            passwordTextField.placeholder = "password"
            passwordTextField.isSecureTextEntry = true
        }
        alert.addTextField { (emailTextField) in
            emailTextField.text = ""
            emailTextField.placeholder = "new Email"
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak alert] (_) in
           
            let emailTextField = alert?.textFields![1]
            let newEmail = emailTextField?.text
            let passwordTextField = alert?.textFields![0]
            let pass = passwordTextField?.text
            self.firebaseManger.updateUserEmail(newEmail!, pass!)
            self.userEmail.text = newEmail
            print("Text field: \(String(describing: newEmail))")
            
        }))

        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func userPasswordEditTapped(_ sender: Any) {
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Edit Your Password", message: "Enter your New Password", preferredStyle: .alert)

        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (oldPasswordTextField) in
            oldPasswordTextField.text = ""
            oldPasswordTextField.placeholder = "old password"
            oldPasswordTextField.isSecureTextEntry = true
        }
        
        alert.addTextField { (newPasswordTextField) in
            newPasswordTextField.text = ""
            newPasswordTextField.placeholder = "new password"
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak alert] (_) in
            let oldPasswordTextField = alert?.textFields![0]
            let oldPass = oldPasswordTextField?.text
            let newPasswordTextField = alert?.textFields![1]
            let newPass = newPasswordTextField?.text
            self.firebaseManger.updateUserPassword(oldPass!, newPass!)
            print("Text field: \(String(describing: newPass))")
        }))

        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func changeProfilePictureButton(_ sender: UIButton) {
        self.showSheetToChangeImage()
    }
}
