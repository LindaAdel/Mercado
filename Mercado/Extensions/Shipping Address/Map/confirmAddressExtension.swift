//
//  confirmAddressExtension.swift
//  Mercado
//
//  Created by Mayar Adel on 5/24/21.
//

import Foundation
import MapKit
extension ConfirmAddressViewController:IMapSearch
{
    //add search bar to the view
    func showSearchBar()  {
        //search
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTableViewController") as! LocationSearchTableViewController
        //to display search results in location search table view
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        
        //configures the search bar, and embeds it within the navigation bar
        let searchBar = resultSearchController?.searchBar
//        searchBar?.sizeToFit()
        searchBar?.placeholder = "search location"
        navigationItem.title = "Shipping Address"
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        
     navigationItem.searchController = resultSearchController
        
        resultSearchController?.obscuresBackgroundDuringPresentation = true
        definesPresentationContext = true
        
        //change cancel button color
        UIBarButtonItem.appearance(whenContainedInInstancesOf:[UISearchBar.self]).tintColor = UIColor.black
        locationSearchTable.mapView = mapView
        locationSearchTable.handleMapSearchDelegate = self
    }
    
    //confirm imapsearch protocol
    //when user select place from table view drop pin
    func dropPinWhenSelectPlace(place: MKPlacemark)
    {
        self.place = place
        // clear existing pins
        mapView!.removeAnnotations((mapView?.annotations)!)
        let annotation = MKPointAnnotation()
        annotation.coordinate = place.coordinate
        annotation.title = place.name
        if let city = place.locality,
        let state = place.administrativeArea
        {
         // annotation.subtitle = "\(city) \(state)"
        }
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: place.coordinate, span: span)
        mapView.setRegion(region, animated: true)
        
        
        
        
    }
}
