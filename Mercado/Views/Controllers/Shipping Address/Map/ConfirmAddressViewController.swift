//
//  ConfirmAddressViewController.swift
//  Mercado
//
//  Created by Mayar Adel on 5/23/21.
//

import UIKit
import MapKit
class ConfirmAddressViewController: UIViewController,MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    
    var resultSearchController:UISearchController? = nil
    var place : MKPlacemark!
   // var address :String!
 
    var address:Address!
    
    //gives access to the location manager
    var locationManager:CLLocationManager!
    var isFromCheckout : Bool = false
    
    weak var addAddressDelegate : IAddAddress!
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - didload
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationItem.backButtonTitle = ""
       address = Address()
        //add search bar to the view
        self.showSearchBar()
        //initialize location manager var
        locationManager = CLLocationManager()
        //location manager to get user current location
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //triggers the location permission dialog. The user will only see the dialog once.
         //   locationManager.requestWhenInUseAuthorization()
            locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled(){
               locationManager.startUpdatingLocation()
           }
    }

    @IBAction func confirmAddressButton(_ sender: Any)
    {
        let addressDetailsVC = storyboard?.instantiateViewController(withIdentifier: String(describing: AddressDetailsViewController.self)) as! AddressDetailsViewController
        if let _ = address
        {
      //  add.country = address
            
            addressDetailsVC.address = address
        }else
        {
                    }
        if let _ = place {
       
            address.street = "\(place.subThoroughfare ?? "") \(place.thoroughfare ?? "")"
            address.area = place.locality!
            address.governorate = place.administrativeArea!
            addressDetailsVC.address = address
        }
        else
        {
           
        }
        if isFromCheckout{
            addressDetailsVC.isFromCheckout = true
        }
        
        self.navigationController?.pushViewController(addressDetailsVC, animated: true)

    }

}
