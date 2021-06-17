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

    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var AccountCurvedView: UIView!
    
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userPassword: UILabel!
    
    var accountViewModel : AccountViewModel!
    var firebaseManger : FirebaseManager!
    var googoleUserPhotoChanged :Bool! = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.showCurvedView()
        StyleSheet.roundImage(userProfileImage)
        firebaseManger = FirebaseManager.shared
        accountViewModel = AccountViewModel()
        accountViewModel.getUploadedImageFromFB()
        accountViewModel.getgetCurrentUserFromFB()
        
    accountViewModel.bindUploadedImageToAccountVIew =
    {
        (img) in
        if let img = img
        {
            let url = URL(string: img)
        DispatchQueue.main.async {
            print("url \(String(describing: url))")
            self.googoleUserPhotoChanged = true
        self.userProfileImage.sd_setImage(with: url, completed: nil)
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
                self.userProfileImage.sd_setImage(with: image, completed: nil)
                    print(self.googoleUserPhotoChanged!)
                }
            }
         
            
       }
    }

        //add gesture to image user tapped
        self.userImageClicked()
    }
    

    @IBAction func backNavButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
    }
    
    @IBAction func userNameEditTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Edit Your username", message: "Enter your New username", preferredStyle: .alert)

        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.text = ""
        }

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
        alert.addTextField { (textField) in
            textField.text = ""
        }

        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak alert] (_) in
            let TextField = alert?.textFields![0]
            let newEmail = TextField?.text
            self.firebaseManger.updateUserEmail(newEmail!)
            self.userEmail.text = newEmail
            print("Text field: \(String(describing: newEmail))")
        }))

        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func userPasswordEditTapped(_ sender: Any) {
    }
}
