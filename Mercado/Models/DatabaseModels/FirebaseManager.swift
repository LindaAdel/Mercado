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
    let favorite : String = "favorite"
    private init(){
        dbreference = Database.database().reference().ref
        currentUser = Auth.auth().currentUser
    }
    static let shared = FirebaseManager()
    let userID = Auth.auth().currentUser?.uid
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
                    print("man\(self.currentUser)")
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
//MARK:- dina
   
        
        func searchForItem(specialItem : SpecialItem, completion : @escaping (NSDictionary?, Error?)->()){
        
            self.dbreference.child("categories")
                .child(specialItem.category!)
                .child(specialItem.subCategory!)
                .child(specialItem.itemId!)
                .getData { (error, snapshot) in
                    
                if let error = error {
                    print("Error getting data \(error)")
                }
                else if snapshot.exists() {
                    let data = snapshot.value as? NSDictionary
                    print(data!)

                    completion(data,nil)
                }
                else {
                    print("No data available")
                    completion(nil,error)

                }
            }
        }
    
    func  addItemsToFavorites(favoriteItem : SpecialItem){
       
        let itemId = favoriteItem.itemId
        let category = favoriteItem.category
        let subCategory = favoriteItem.subCategory
        self.dbreference.child("\(favorite)/\(userID!)/\(itemId!)/itemId").setValue(itemId!)
        self.dbreference.child("\(favorite)/\(userID!)/\(itemId!)/category").setValue(category!)
        self.dbreference.child("\(favorite)/\(userID!)/\(itemId!)/subCategory").setValue(subCategory!)
      
    }
    func  removeItemsFromFavorites(favoriteItem : SpecialItem){
            let itemId = favoriteItem.itemId
        dbreference?.child("favorite").child(userID!).child(itemId!).removeValue()
        }
    
    func fetchItemIsFavoriteData(itemId : String ,completion : @escaping ( Bool , Error?)->()){
       
        self.dbreference.child("favorite").child(userID!).child(itemId).getData { (error, Datasnapshot) in
       
            if let error = error {
                completion(false , error)
                print("Error getting data \(error)")
            }
            else {
                completion(Datasnapshot.exists(),nil)
            }
        
    }
       
    }
    
}
