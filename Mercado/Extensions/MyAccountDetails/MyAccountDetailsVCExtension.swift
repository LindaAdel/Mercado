//
//  MyAccountDetailsVCExtension.swift
//  Mercado
//
//  Created by Linda adel on 6/17/21.
//

import Foundation
import UIKit
import Firebase
extension MyAccountDetailsViewController : UIImagePickerControllerDelegate ,  UINavigationControllerDelegate {
    
func showCurvedView()
{

    let maskLayer = CAShapeLayer(layer: AccountCurvedView.layer)
    let bezierPath = UIBezierPath()
    bezierPath.move(to: CGPoint(x:0, y:0))
    bezierPath.addLine(to: CGPoint(x:AccountCurvedView.bounds.size.width, y:0))
    bezierPath.addLine(to: CGPoint(x:AccountCurvedView.bounds.size.width, y:AccountCurvedView.bounds.size.height))
    bezierPath.addQuadCurve(to: CGPoint(x:0, y:AccountCurvedView.bounds.size.height), controlPoint: CGPoint(x:AccountCurvedView.bounds.size.width/2, y:AccountCurvedView.bounds.size.height-AccountCurvedView.bounds.size.height*0.3))
    bezierPath.addLine(to: CGPoint(x:0, y:0))
    bezierPath.close()
    maskLayer.path = bezierPath.cgPath
    maskLayer.frame = AccountCurvedView.bounds
    maskLayer.masksToBounds = true
    AccountCurvedView.layer.mask = maskLayer
}
 
    //open action sheet when user tapped on user image
    func showSheetToChangeImage()
    {
    
        //set title to action sheet
        let alert = UIAlertController(title: "Change Profile Photo", message: nil, preferredStyle: .actionSheet)
        //remove photo action
        alert.addAction(Alert().addAlertAction(alertActionTitle: "Remove Current Photo", titleColor: .black, alertActionStyle: .default, alertActionhandler: self.removeCurrentPhotoHandler(_:)))
        alert.addAction(Alert().addAlertAction(alertActionTitle: "Choose From Library", titleColor: .black, alertActionStyle: .default, alertActionhandler: self.chooseFromLibraryHandler(_:)))

        alert.addAction(Alert().addAlertAction(alertActionTitle: "Take Photo", titleColor:.black, alertActionStyle: .default, alertActionhandler: self.takePhotoHandler(_:)))
        alert.addAction(Alert().addAlertAction(alertActionTitle: "cancel", titleColor: .systemBlue, alertActionStyle: .cancel, alertActionhandler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    //when user click remove photo
    func removeCurrentPhotoHandler(_ action:UIAlertAction){
        //set default pic
        userProfileImage.image = UIImage(systemName: "person.circle")
        //remove pic from db
        accountViewModel.removeUploadedImageFromFB()
        
    }
    //image picker func to choose open camera or library
    func imagePickerController(allowEditing:Bool,sourceType:UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = sourceType;
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
        userProfileImage.image = image
        //upload image to storage and db
        self.accountViewModel
            .uploadImageToStorageAndDB(selectedImage:image)
            dismiss(animated:true, completion: nil)
       
    }
}
