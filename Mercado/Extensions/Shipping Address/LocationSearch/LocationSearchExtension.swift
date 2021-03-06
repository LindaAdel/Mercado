//
//  LocationSearchTableViewExtension.swift
//  Mercado
//
//  Created by Mayar Adel on 5/23/21.
//

import Foundation
import MapKit
extension LocationSearchTableViewController : UISearchResultsUpdating
{
  
    
    //Set up location search api
    func updateSearchResults(for searchController: UISearchController) {
       
        checkConnectivity()
        guard let mapView = mapView ,
              let searchBarTextValue = searchController.searchBar.text
        else {
            return
        }
        
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchBarTextValue
        request.region = mapView.region
        //request search in region map
        let searchRequestFromAPI = MKLocalSearch(request: request)
        searchRequestFromAPI.start(){ [self](response ,error) in
            guard let regionResponseResult = response
            else {
                return
            }
            self.matchingItemsArray = regionResponseResult.mapItems
            self.tableView.reloadData()
            //update searchbar text with selected place
            if  let place = self.selectedPlace
           {
            self.selectedPlace = nil
                searchController.searchBar.text = place
           }
        
    }
    }
    

}

