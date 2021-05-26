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
    var address :String!
 
    
    
    //gives access to the location manager
    var locationManager:CLLocationManager!
    
    weak var addAddressDelegate : IAddAddress!
    // MARK: - didload
    override func viewDidLoad()
    {
        super.viewDidLoad()
       
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
        if let placee = place {
            address = ParseAddress().parseAddressToString(selectedAddress: placee)
            print("add \(address)")
            print(addAddressDelegate)
            
            print("placee \(ParseAddress().parseAddressToString(selectedAddress: placee))")
            print("place admin : \(String(describing: placee.administrativeArea))")
            print("place subt: \(String(describing: placee.subAdministrativeArea))")
            print("loc: \(String(describing: placee.locality))")
          }
        if let _ = address
        {
        self.addAddressDelegate.setLocation(address: self.address)
        }
        self.navigationController?.popViewController(animated: true)
    }
}
