//
//  AccountViewModel.swift
//  Mercado
//
//  Created by Mayar Adel on 5/25/21.
//

import Foundation
import UIKit
import Firebase
class AccountViewModel
{
    let firebaseManager : FirebaseManager!

    
    var bindUserNameToAccountView :((String?,User?)->())!
    var bindCurrentUserToAccountView :((User?)->())!
    init() {
        firebaseManager = FirebaseManager.shared
    }
    var bindUploadedImageToAccountVIew :((String?)->())!
    func getUploadedImageFromFB(){
        firebaseManager.getUploadedImage()
        {
            (imgURL) in
            print("imgvm \(imgURL)")
            self.bindUploadedImageToAccountVIew(imgURL)
           
            
        }
    }
    func removeUploadedImageFromFB() {
        firebaseManager.removeUploadedImage()
    }
    func uploadImageToStorageAndDB(selectedImage:UIImage)
    {
          firebaseManager
           .uploadImageToFirebaseStorage(selectedImage: selectedImage)
    }
    //MARK:- get current user
    func getgetCurrentUserFromFB(){
        firebaseManager.getCurrentUser(){
         (username,user) in
            if let name = username
            {
               self.bindUserNameToAccountView(name,user)
                //   self.username = name
                print("get current user \(name)")
            }
            else
            {
                print("eerror get name viewmodel")
                //print(error?.localizedDescription)
                self.bindUserNameToAccountView(nil,user)
            }
        }
    }
    //MARK:- update user
//    func getCurrentUserFromFb()
//    {
//        
//        firebaseManager.getCurrentUser()
//        {
//            (user) in
////            guard let user = user else {
////                print("user nil")
////                return
////
////            }
//            print("user \(user)")
//            self.bindCurrentUserToAccountView = {_ in}
//            self.bindCurrentUserToAccountView(user)
//        }
//    }
//    
}
