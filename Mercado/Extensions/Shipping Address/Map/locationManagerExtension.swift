//
//  locationManagerExtension.swift
//  Mercado
//
//  Created by Mayar Adel on 5/24/21.
//

import Foundation
import MapKit
extension ConfirmAddressViewController:CLLocationManagerDelegate
{
    // This method gets called when the user responds to the permission dialog
     func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
         print("status \(status)")
         //If the user chose Allow, the status becomes CLAuthorizationStatus.AuthorizedWhenInUse
         if status == .authorizedWhenInUse {
                    locationManager.requestLocation()
                }
         if status == .denied
         {
             locationManager.requestLocation()
         }
         if status == .notDetermined
         {
             locationManager.requestWhenInUseAuthorization()
         }
        
     }
    
    
    //This gets called when location information comes back
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.first {
            print("long :\(String(describing: location.coordinate.longitude))")
            print("lat :\(String(describing: location.coordinate.latitude))")
            
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                   let region = MKCoordinateRegion(center: location.coordinate, span: span)
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!)
           // annotation.coordinate = center
            mapView.addAnnotation(annotation)
            mapView.selectAnnotation(mapView.annotations[0], animated: true)
            mapView.setRegion(region, animated: true)
            self.getPlace(for: location)
                {
                (pla) in
               
                let streetNumber = pla?.subThoroughfare ?? ""
                let street = pla?.thoroughfare ?? ""
                let city = pla?.administrativeArea ?? ""
                let area = pla?.locality ?? ""
//                self.address = streetNumber + " " + street + " " + state + ", " + city
                
                //print("add : \(self.address!)")
                print("ni : \(streetNumber)")
                print("(stre\(street)")
                print("area \(area)")
                print("cit\(city)")
                self.address.street = streetNumber + street
                self.address.governorate = city
                self.address.area = area
            }
                }

    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("location error \(error)")
    }
    func getPlace(for location: CLLocation,
                      completion: @escaping (CLPlacemark?) -> Void) {
            
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location) { placemarks, error in
                
                guard error == nil else {
                    print("*** Error in \(#function): \(error!.localizedDescription)")
                    completion(nil)
                    return
                }
                
                guard let placemark = placemarks?[0] else {
                    print("*** Error in \(#function): placemark is nil")
                    completion(nil)
                    return
                }
                
                completion(placemark)
            }
        }
}

