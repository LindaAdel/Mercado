//
//  AddressViewModel.swift
//  Mercado
//
//  Created by Mayar Adel on 6/20/21.
//

import Foundation
class AddressViewModel {
    var firebaseManager : FirebaseManager!
    var bindAddressToAddAddressView : ((Address?)->())!
    init() {
        firebaseManager = FirebaseManager.shared
    }
    func addAddressToFB(address:Address) {
        firebaseManager.addAddressToFB(address: address)
    }
    func getAddressFromFB() {
        firebaseManager.getUserAddress(){
            address in
          
            self.bindAddressToAddAddressView(address)
        }
    }
    func removeAddressFromFb() {
        firebaseManager.removeAddressFromFB()
        
    }
}
