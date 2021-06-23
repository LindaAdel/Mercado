//
//  AddressDetailsViewController.swift
//  Mercado
//
//  Created by Mayar Adel on 6/20/21.
//

import UIKit

class AddressDetailsViewController: UIViewController {
    
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var landmarkTextField: UITextField!
    @IBOutlet weak var apartmentTextField: UITextField!
    @IBOutlet weak var floorTextField: UITextField!
    @IBOutlet weak var buildingTextField: UITextField!
    @IBOutlet weak var streetTextField: UITextField!
    @IBOutlet weak var areaTextField: UITextField!
    @IBOutlet weak var governorateTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    var address :Address!
    var addressViewModel :AddressViewModel!
    var isFromCheckout : Bool = false
    @IBOutlet weak var scrolling: UIScrollView!
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrolling.contentOffset.x = 0
        addressViewModel = AddressViewModel()
        
        //change textfields style
        self.showTextFieldsStyle()
        //self.navigationItem.backButtonTitle = ""
        title = "Add Address"
        guard address.street != nil ,
              address.governorate != nil,
              address.area != nil
        else
        {
            return
            
        }
        streetTextField.text = address.street!
        governorateTextField.text = address.governorate!
        areaTextField.text = address.area!
        print(address.street!)
        print(address.governorate!)
        print(address.area!)
        guard address.apartment != nil ,
              address.building != nil,
              address.floor != nil ,
              address.country != nil,
              address.nearestLandmark != nil,
              address.mobileNumber != nil
        else {
            print("no edit")
            return
        }
        apartmentTextField.text =  address.apartment
        buildingTextField.text = address.building
        floorTextField.text = address.floor
        countryTextField.text = address.country
        landmarkTextField.text = address.nearestLandmark
        mobileTextField.text = address.mobileNumber

    }
    
    
    @IBAction func saveAddressButton(_ sender: UIButton)
    {
        print("address saved")
        if
            countryTextField.isEmptyField() &&
                governorateTextField.isEmptyField() &&
                areaTextField.isEmptyField() &&
                streetTextField.isEmptyField() &&
                buildingTextField.isEmptyField() &&
                floorTextField.isEmptyField() &&
                apartmentTextField.isEmptyField() &&
                landmarkTextField.isEmptyField() &&
                mobileTextField.isEmptyField()
        {
            print("all fields are empty")
        }
        else{
            if countryTextField.isEmptyField() {print("country required")}
            if  governorateTextField.isEmptyField() {print("governorate required")}
            if areaTextField.isEmptyField() { print("area required")}
            if  streetTextField.isEmptyField(){ print("street required")}
            if buildingTextField.isEmptyField() {print("building required")}
            if floorTextField.isEmptyField() {print("floor required")}
            if apartmentTextField.isEmptyField() {print("apartment required")}
            if landmarkTextField.isEmptyField() {print("landmark required")}
            if mobileTextField.isEmptyField() {print("mobile required")}
            else
            {
                let addAddressVc = storyboard?.instantiateViewController(identifier: String(describing: AddAddressTableViewController.self)) as! AddAddressTableViewController
                address.apartment = apartmentTextField.text
                address.building = buildingTextField.text
                address.floor = floorTextField.text
                address.country = countryTextField.text
                address.nearestLandmark = landmarkTextField.text
                address.mobileNumber = mobileTextField.text
                address.street =  streetTextField.text
               address.governorate =  governorateTextField.text
                address.area = areaTextField.text
                addressViewModel.addAddressToFB(address: self.address)
                addAddressVc.addressesArray.append(address)
                if isFromCheckout{
                    addAddressVc.isFromCheckout = true
                }
                self.navigationController?.pushViewController(addAddressVc , animated: true)
            }
            
        }
        
    }
    
    
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
