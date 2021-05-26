//
//  Firebase.swift
//  Mercado
//
//  Created by Mayar Adel on 5/22/21.
//

import Foundation
import Firebase
import UIKit
class FirebaseManager
{
    var dbreference: DatabaseReference!
    let currentUser :User!
    private init(){
        dbreference = Database.database().reference().ref
        currentUser = Auth.auth().currentUser
    }
    static let shared = FirebaseManager()
    
    
//    let currentUser = Auth.auth().currentUser
    let userID = Auth.auth().currentUser?.uid
//    func getCurrentUser(completion:@escaping ((User?)->())){
//        guard currentUser != nil else {
//            print("no user")
//            return
//        }
//        print("current \(currentUser?.email)")
//        completion(currentUser)
//    }
    
    //MARK:- get uploaded image
    func getUploadedImage(completion:@escaping ((String?)->())){
        dbreference.child("users")
            .child(userID!)
            .child("photo")
            .getData(){
                (error,snapShot) in
               
              
                guard error == nil else { print ("fb error img \(String(describing: error?.localizedDescription))")
                    print(self.userID!)
                    return}
                print("fb img : \(snapShot.value!)")
                if snapShot.exists(){
                    print("img found")
                    completion((snapShot.value) as? String)
                     }
                
                        
                
            }
        
    }
    func removeUploadedImage() {
        dbreference.child("users")
            .child(userID!)
            .child("photo").removeValue()
        
    }
    //MARK:- get current user
    func getCurrentUser( completion: @escaping ((String?,User?)->()))
    {
        dbreference.child("users").child(userID! ).child("username").getData { (error, snapshot) in
            if let error = error {
                print("Error getting data \(error)")
              // completion(nil, error.localizedDescription)
            }
            else  {
                print("Got data \(snapshot.value!)")
                //check if user created acc and has user name
                if snapshot.value! is String
                {
                    completion(snapshot.value! as? String, self.currentUser)
                }
                //if user loged froom google acc
                else
                {
                    completion(nil, self.currentUser)
                }
                
            }
           
        }
       
    }
    //MARK:- upload img to storage
    func uploadImageToFirebaseStorage(selectedImage:UIImage?)
    {
        
        guard let image = selectedImage else
        {
            print("selected image nil")
            return
        }
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            return
        }
        let storageReference = Storage.storage().reference()
        let storageUserProfileReference = storageReference.child("users").child(userID!)
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        storageUserProfileReference.putData(imageData, metadata: metaData){
            (metadata , error)  in
            if error == nil && metadata != nil
            {
                storageUserProfileReference.downloadURL()
                {
                    (url,error) in
                    let imageURL = url?.absoluteURL
                    self.uploadImageURLToDB(imageURL: imageURL!)
                    print("url img \(url?.absoluteString ?? nil)")
                }
            }
            else
            {
                print(error?.localizedDescription)
            }
        }
    }
    
    //MARK:- upload img to db
    func uploadImageURLToDB(imageURL : URL)
    {
        dbreference
       .child("users")
       .child(userID! )
       .updateChildValues(["photo": String(describing: imageURL)])
        print("uploadated to db")
    }

}
