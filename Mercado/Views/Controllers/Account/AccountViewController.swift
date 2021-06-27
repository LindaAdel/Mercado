//
//  AccountViewController.swift
//  Mercado
//
//  Created by Mayar Adel on 5/22/21.
//

import UIKit
import FirebaseAuth
import SDWebImage
import Firebase
class AccountViewController: UIViewController
{


    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var curvedView: UIView!
    
    @IBOutlet weak var cameraIcon: UIButton!
    var accountViewModel :AccountViewModel!
    let accountDetailsArray = AccountDetails().accountDetailsArray
    
    var googoleUserPhotoChanged :Bool! = false
    override func viewDidLoad() {
        super.viewDidLoad()
          
     //   print(Auth.auth().currentUser?.email)
        
        cameraIcon.layer.cornerRadius = cameraIcon.frame.width / 2
        cameraIcon.layer.borderWidth = 1
        cameraIcon.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        cameraIcon.clipsToBounds = true
        self.showCurvedView()
        accountViewModel = AccountViewModel()
        
        //rounded image
        StyleSheet.roundImage(userImage)
     
        
        
    accountViewModel.bindUploadedImageToAccountVIew =
    {
        (img) in
       
        if let img = img
        {
            let url = URL(string: img)
        DispatchQueue.main.async {
            print("url \(String(describing: url))")
            self.googoleUserPhotoChanged = true
            self.userImage.sd_setImage(with: url, placeholderImage: UIImage(systemName: "person.circle"), context: nil)
        //self.userImage.sd_setImage(with: url, completed: nil )
        }
        }

    }
    accountViewModel.bindUserNameToAccountView =
    {
        (userName,user) in
        DispatchQueue.main.async {
           self.userNameLabel.text = userName
            print("done")
            self.userEmailLabel.text = user?.email!
            if let googleAccountDisplayName = user?.displayName
            {
                self.userNameLabel.text = googleAccountDisplayName
            }
            if let image = user?.photoURL
            {
                if self.googoleUserPhotoChanged == false
                {
                self.userImage.sd_setImage(with: image , placeholderImage: UIImage(systemName: "person.circle"), completed: nil)
                    print(self.googoleUserPhotoChanged!)
                }
            }
            print("user done")
            
       }
    }

        //add gesture to image user tapped
    //    self.userImageClicked()
    
    }
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        print("will appear")
        checkConnectivity()
        accountViewModel.getUploadedImageFromFB()
        accountViewModel.getgetCurrentUserFromFB()

        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func changeProfilePictureButton(_ sender: UIButton) {
        self.showSheetToChangeImage()
    }
    
    @IBAction func logoutButton(_ sender: Any)
    {
        //add alert to confirm or cancel logout
        let cancelAction = Alert().addAlertAction(alertActionTitle: "Cancel", titleColor: .systemBlue, alertActionStyle: .cancel, alertActionhandler: nil)
        let logoutAction = Alert().addAlertAction(alertActionTitle: "Logout", titleColor: .red, alertActionStyle: .default, alertActionhandler: self.logoutHandler(_:))
        Alert().showAlert(alertTitle: "Logout", alertMessage: "Are you sure you want to logout?", alertActionOne: cancelAction, alertActionTwo: logoutAction,Self:self)
        
        

    }
    

}

