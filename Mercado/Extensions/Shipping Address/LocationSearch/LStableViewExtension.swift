//
//  LStableViewExtension.swift
//  Mercado
//
//  Created by Mayar Adel on 5/24/21.
//

import Foundation
import UIKit
extension LocationSearchTableViewController
{
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingItemsArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath)
      let selectedAddress = matchingItemsArray[indexPath.row].placemark
        cell.textLabel?.text = selectedAddress.name
        
        cell.detailTextLabel?.text = ParseAddress().parseAddressToString(selectedAddress :selectedAddress)
        

        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        //to update searchbar text with selected place
        selectedPlace = matchingItemsArray[indexPath.row].placemark.name
        //drop pin in the map with the selected place
        handleMapSearchDelegate?.dropPinWhenSelectPlace(place: matchingItemsArray[indexPath.row].placemark)
        dismiss(animated: true, completion: nil)
    }
    
}
