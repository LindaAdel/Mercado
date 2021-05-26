//
//  ParseAddress.swift
//  Mercado
//
//  Created by Mayar Adel on 5/24/21.
//

import Foundation
import MapKit
struct ParseAddress {
    func parseAddressToString(selectedAddress:MKPlacemark) -> String {
        // put a space between "4" and "Melrose Place"
        let firstSpace = (selectedAddress.subThoroughfare != nil && selectedAddress.thoroughfare != nil) ? " " : ""
        // put a comma between street and city/state
        let comma = (selectedAddress.subThoroughfare != nil || selectedAddress.thoroughfare != nil) && (selectedAddress.subAdministrativeArea != nil || selectedAddress.administrativeArea != nil) ? ", " : ""
        // put a space between "Washington" and "DC"
        let secondSpace = (selectedAddress.subAdministrativeArea != nil && selectedAddress.administrativeArea != nil) ? " " : ""
        let addressLine = String(
            format:"%@%@%@%@%@%@%@",
            // street number
            selectedAddress.subThoroughfare ?? "",
            firstSpace,
            // street name
            selectedAddress.thoroughfare ?? "",
            comma,
            // city
            selectedAddress.locality ?? "",
            secondSpace,
            
            // state
            selectedAddress.administrativeArea ?? ""
           
        )
        return addressLine
    }
}
