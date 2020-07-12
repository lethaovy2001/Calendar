//
//  MKMapItem+Extension.swift
//  Calendar
//
//  Created by Vy Le on 7/11/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit
import MapKit

extension MKMapItem {
    var address: String {
        get {
            var addressString = ""
            if placemark.subThoroughfare != nil {
                addressString = "\(addressString + placemark.subThoroughfare!) "
            }
            if placemark.subLocality != nil {
                addressString = "\(placemark.subLocality!), "
            }
            if placemark.thoroughfare != nil {
                addressString += "\(placemark.thoroughfare!), "
            }
            if placemark.locality != nil {
                addressString += "\(placemark.locality!), "
            }
            if placemark.country != nil {
                addressString += "\(placemark.country!), "
            }
            if placemark.postalCode != nil {
                addressString += "\(placemark.postalCode!)"
            }
            return addressString
        }
    }
}
