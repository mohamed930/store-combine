//
//  CLLocation.swift
//  store
//
//  Created by Mohamed Ali on 28/07/2023.
//

import Foundation
import MapKit
import Contacts

extension CLPlacemark {
    // street name, eg. Infinite Loop
    var streetName: String? { thoroughfare }
    // // eg. 1
    var streetNumber: String? { subThoroughfare }
    // city, eg. Cupertino
    var city: String? { locality }
    // neighborhood, common name, eg. Mission District
    var neighborhood: String? { subLocality }
    // state, eg. CA
    var state: String? { administrativeArea }
    // county, eg. Santa Clara
    var county: String? { subAdministrativeArea }
    // zip code, eg. 95014
    var zipCode: String? { postalCode }
    // postal address formatted
    var postalAddressFormatted: String? {
        guard let postalAddress = postalAddress else { return nil }
        return CNPostalAddressFormatter().string(from: postalAddress)
    }
}

extension CLLocation {
    func placemark(completion: @escaping (_ placemark: CLPlacemark?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first, $1) }
    }
}
