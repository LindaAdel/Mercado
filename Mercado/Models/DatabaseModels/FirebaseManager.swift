//
//  Firebase.swift
//  Mercado
//
//  Created by Mayar Adel on 5/22/21.
//


import Firebase
import UIKit
import CodableFirebase
class FirebaseManager
{
    var dbreference: DatabaseReference!
    let currentUser :User!
    let userID : String!
    let userEmail : String!
    let favorite : String = "favorite"
    let order : String = "orders"
    static let shared = FirebaseManager()
    
    private init(){
        dbreference = Database.database().reference().ref
        currentUser = Auth.auth().currentUser
        userID = currentUser.uid
        userEmail = currentUser.email
        
    }
    //MARK:- cart
    func checkItemInCart(currentCartId:String ,completion:@escaping ((Bool)->())) {
        dbreference.child("cart")
            .child(userID)
            .child(currentCartId)
            .getData()
            {
                (error,snapshot) in
                guard error == nil
                else{
                    print("error check \(error?.localizedDescription)")
                    return
                }
                if snapshot.exists()
                {
                    completion(true)
                }
                else
                {
                    completion(false)
                }
            }
    }
    func updateCountValue(countValue:Int,currentItemId:String)
    {
        dbreference.child("cart")
            .child(userID)
            .child(currentItemId)
            .updateChildValues(["count":countValue])
        print(" count updated \(currentItemId)")
    }
    func addItemToFirebaseCart(cartItem :CartItem)   {
        let item = [
            "category":cartItem.category!,
            "itemId":cartItem.itemId!,
            "subCategory":cartItem.subCategory!,
            "count":cartItem.count!,
        ] as [String : Any]
        dbreference.child("cart")
            .child(userID)
            .child(cartItem.itemId!)
            .updateChildValues(item)
        print("item added to cart")
    }
    func removeItemfromFirebaseCart(itemId :String)   {
        dbreference.child("cart")
            .child(userID)
            .child(itemId)
            .removeValue()
        print("item removed from cart")
    }
    //get every item details in cart from db
    func searchForItemsInCart<T:Codable>(of : T.Type,cartItem:CartItem,completion:@escaping (T?)->()) {
        dbreference.child("categories")
            .child(cartItem.category!)
            .child(cartItem.subCategory!)
            .child(cartItem.itemId!)
            .getData()
            {
                (error,snapshot) in
                guard error == nil
                else{
                    print("error in search cart \(String(describing: error?.localizedDescription))")
                    return
                }
                if snapshot.exists()
                {
                    print("firebaseSearch")
                    //    print(snapshot.value)
                    let item = try! FirebaseDecoder().decode(T.self, from: snapshot.value!)
                    //  print("item fb \(item)")
                    completion(item)
                    
                }
                else
                {
                    print("firebase Search : item not found \(String(describing: snapshot.value)) \(String(describing: cartItem.itemId)) \(String(describing: cartItem.category)) \(String(describing: cartItem.subCategory))")
                }
            }
    }
    func getCartItemsFromFirebase(completion :@escaping ([CartItem]?)->()){
        dbreference.child("cart")
            .child(userID).getData(){
                (error,snapshot)in
                guard error == nil
                else
                {
                    print("get cart error \(error?.localizedDescription as Any)")
                    return
                }
                var cartItemsArray = [CartItem]().self
                if snapshot.exists()
                {
                    for item in snapshot.children {
                        let itemDecoded = try! FirebaseDecoder().decode(CartItem.self, from: (item as AnyObject).value!)
                        cartItemsArray.append(itemDecoded)
                    }
                    print("fb \(cartItemsArray.count)")
                    completion(cartItemsArray)
                   
                }
                else{
                    print("empty cart \(snapshot.value!)")
                    completion(nil)
                    
                }
                
                
            }
        
    }
    
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
    //MARK:- remove image
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
    //MARK:- dina Favorite
    
    
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
    
    //Add order to firebase
    func addOrder(orderItem : Order){
        
        let shippingAddress = orderItem.shippingAddress
        let totalPrice = orderItem.totalPrice
        
        let ordersRef = self.dbreference.child("\(order)/\(userID!)")
        let pushRef = ordersRef.childByAutoId()
    
        pushRef.child("shippingAddress").setValue(shippingAddress!)
        pushRef.child("totalPrice").setValue(totalPrice!)
        
        let itemsArray = orderItem.items
        for item in itemsArray! {
       
            let itemId = item.itemId
            let count = item.count
            pushRef.child("items/\(itemId!)/itemId").setValue(itemId!)
            pushRef.child("items/\(itemId!)/count").setValue(count!)
            
        }
        
    }
    
    func removeCartItems(){
        dbreference?.child("cart").child(userID!).removeValue()
    }
    //MARK:- update user name
    func updateUserName(_ name : String){
        self.dbreference?.child("users").child("\(self.userID!)/username").setValue(name)
    }
    //MARK:- update user mail
    func updateUserEmail(_ email : String , _ password : String){
       
        if email != userEmail{
            
        let credential: AuthCredential = EmailAuthProvider.credential(withEmail: userEmail, password: password)
           
          
           changeEmail(credential,email)
           
        }
   
    }
    func changeEmail(_ credential : AuthCredential , _ email : String) {
        if (currentUser != nil) {
            // re authenticate the user
            currentUser.reauthenticate(with: credential) { userID,error  in
                if let error = error {
                    // An error happened.
                    print(error)
                    print("there is an error")
                } else {
                    // User re-authenticated.
                    self.currentUser.updateEmail(to: email ) { (error) in
                    self.dbreference?.child("users").child("\(self.userID!)/userEmail").setValue(email)
                        print("mail updated")
                        // email updated
                    }
                }
            }
        }
    }
    //MARK:- update user password
    func updateUserPassword(_ oldPassword : String , _ newPassword : String){
  
        let credential: AuthCredential = EmailAuthProvider.credential(withEmail: userEmail, password: oldPassword)
        
            changePassword(credential,newPassword)
  
    }
    func changePassword(_ credential : AuthCredential, _ newPassword : String) {
        if (currentUser != nil) {
            // re authenticate the user
            currentUser.reauthenticate(with: credential) { userID,error    in
               
                if let error = error {
                    // An error happened.
                    print(error)
                } else {
                    // User re-authenticated.
                    self.currentUser.updatePassword(to: newPassword) { (error) in
                        // password updated
                    }
                }
            }
        }
    }
}
