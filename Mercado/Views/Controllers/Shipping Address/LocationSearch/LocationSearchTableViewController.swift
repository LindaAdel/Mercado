//
//  SearchTableViewController.swift
//  Mercado
//
//  Created by Mayar Adel on 5/23/21.
//

import UIKit
import MapKit
class LocationSearchTableViewController: UITableViewController
{
   //declare instance from protocol to update map after user select specific place
    weak var  handleMapSearchDelegate :IMapSearch?
    var mapView: MKMapView? = nil
    
    //save selected place in this valriable to update bar text
    var selectedPlace :String?
    
    //to store resulted from search in it
    var matchingItemsArray:[MKMapItem]!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        matchingItemsArray = []
      
    }



   
  
}

