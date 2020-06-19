//
//  LocationService.swift
//  Calendar
//
//  Created by Vy Le on 6/19/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import CoreLocation
import UIKit

class LocationService {
    var locationManager: CLLocationManager?
    static let shared = LocationService()
    
    init() {
        locationManager = CLLocationManager()
        locationManager?.requestAlwaysAuthorization()
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.startUpdatingLocation()
        locationManager?.allowsBackgroundLocationUpdates = false
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func didUpdateLocation(_ location: CLLocation) {
            print(location.coordinate.latitude)
            print(location.coordinate.longitude)
    }
    
    func didChangeAuthorization(status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
           break
        case .denied, .restricted, .notDetermined:
           break
        default:
            break
        }
    }
}
