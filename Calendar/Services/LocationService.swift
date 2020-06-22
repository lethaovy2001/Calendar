//
//  LocationService.swift
//  Calendar
//
//  Created by Vy Le on 6/19/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import CoreLocation
import UIKit
import MapKit

class LocationService {
    var locationManager: CLLocationManager
    var mapView: MKMapView?
    static let shared = LocationService()
    
    init() {
        locationManager = CLLocationManager()
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.allowsBackgroundLocationUpdates = false
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func didUpdateLocations(_ locations: [CLLocation]) {
        if let location = locations.last {
            centerMapOnLocation(location: location)
            locationManager.stopUpdatingLocation()
        }
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: location.coordinate, span: span)
        self.mapView?.setRegion(region, animated: true)
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
