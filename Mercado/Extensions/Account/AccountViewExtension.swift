//
//  AccountViewExtension.swift
//  Mercado
//
//  Created by Mayar Adel on 5/22/21.
//

import Foundation
import UIKit
import Firebase
extension AccountViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate
{

    //add gesture to image
    func userImageClicked(){
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(userImageTappedGestureAction(tapGestureRecognizer:)))
           userImage.isUserInteractionEnabled = true
           userImage.addGestureRecognizer(tapGestureRecognizer)
    }
    //open action sheet when user tapped on user image
    @objc func userImageTappedGestureAction(tapGestureRecognizer: UITapGestureRecognizer)
    {
        print("image tapped")
        //set title to action sheet
        let alert = UIAlertController(title: "Change Profile Photo", message: nil, preferredStyle: .actionSheet)
        //remove photo action
        alert.addAction(Alert().addAlertAction(alertActionTitle: "Remove Current Photo", titleColor: .black, alertActionStyle: .default, alertActionhandler: self.removeCurrentPhotoHandler(_:)))
        alert.addAction(Alert().addAlertAction(alertActionTitle: "Choose From Library", titleColor: .black, alertActionStyle: .default, alertActionhandler: self.chooseFromLibraryHandler(_:)))

        alert.addAction(Alert().addAlertAction(alertActionTitle: "Take Photo", titleColor:.black, alertActionStyle: .default, alertActionhandler: self.takePhotoHandler(_:)))
        alert.addAction(Alert().addAlertAction(alertActionTitle: "cancel", titleColor: .systemBlue, alertActionStyle: .cancel, alertActionhandler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    //when user click logout
    func logoutHandler(_ action:UIAlertAction){
        try! Auth.auth().signOut()
    }
    //when user click remove photo
    func removeCurrentPhotoHandler(_ action:UIAlertAction){
        //set default pic
        userImage.image = UIImage(systemName: "person.circle")
        //remove pic from db
        accountViewModel.removeUploadedImageFromFB()
        
    }
    //image picker func to choose open camera or library
    func imagePickerController(allowEditing:Bool,sourceType:UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .photoLibrary;
                imagePicker.allowsEditing = allowEditing
            self.present(imagePicker, animated: true, completion: nil)
            }
    }
    //choose from library action
    func chooseFromLibraryHandler(_ action:UIAlertAction){
        self.imagePickerController(allowEditing: true, sourceType: .photoLibrary)
    }
    //open camera action
    func takePhotoHandler(_ action:UIAlertAction){
        print("camera")
        self.imagePickerController(allowEditing: false, sourceType: .camera)
    }
    //call back func when user choose or take photo
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        //get image that the user has been choosen
        let image =
            info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            userImage.image = image
        //upload image to storage and db
        self.accountViewModel
            .uploadImageToStorageAndDB(selectedImage:image)
            dismiss(animated:true, completion: nil)
       
    }

//    func uploadImageToFirebaseStorage()
//    {
//        let userId = Auth.auth().currentUser?.uid
//        guard let image = self.selectedImage else
//        {
//            print("selected image nil")
//            return
//        }
//        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
//            return
//        }
//        let storageReference = Storage.storage().reference()
//        let storageUserProfileReference = storageReference.child("users").child(userId!)
//        let metaData = StorageMetadata()
//        metaData.contentType = "image/jpg"
//        storageUserProfileReference.putData(imageData, metadata: metaData){
//            (metadata , error)  in
//            if error == nil && metadata != nil
//            {
//                storageUserProfileReference.downloadURL()
//                {
//                    (url,error) in
//                    let imageURL = url?.absoluteURL 
//                    self.uploadImageURLToDB(imageURL: imageURL!)
////                    print("url img \(url?.absoluteString ?? nil)")
//                }
//            }
//        }
//    }

//    func uploadImageURLToDB(imageURL : URL)
//    {
//        
//                    let userID = Auth.auth().currentUser?.uid
//                    Database.database().reference().child("users").child(userID! ).updateChildValues(["photo": String(describing: imageURL)])
//    }
    func showCurvedView()
    {
        print("curved")
        let maskLayer = CAShapeLayer(layer: curvedView.layer)
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x:0, y:0))
        bezierPath.addLine(to: CGPoint(x:curvedView.bounds.size.width, y:0))
        bezierPath.addLine(to: CGPoint(x:curvedView.bounds.size.width, y:curvedView.bounds.size.height))
        bezierPath.addQuadCurve(to: CGPoint(x:0, y:curvedView.bounds.size.height), controlPoint: CGPoint(x:curvedView.bounds.size.width/2, y:curvedView.bounds.size.height-curvedView.bounds.size.height*0.3))
        bezierPath.addLine(to: CGPoint(x:0, y:0))
        bezierPath.close()
        maskLayer.path = bezierPath.cgPath
        maskLayer.frame = curvedView.bounds
        maskLayer.masksToBounds = true
        curvedView.layer.mask = maskLayer
    }
    
}
