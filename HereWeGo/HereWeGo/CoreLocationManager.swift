//
//  CoreLocationManager.swift
//  HereWeGo
//
//  Created by Ian Hoyos on 2/7/24.
//

import Foundation
import CoreLocation

class CoreLocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    static let shared = CoreLocationManager()
    
    private let locationManager = CLLocationManager()
    @Published var userPosition: CLLocationCoordinate2D?
    
    override init() {
        super.init()
        locationManager.delegate = self
//        locationManager.allowsBackgroundLocationUpdates = true
//        locationManager.showsBackgroundLocationIndicator = true
        locationManager.pausesLocationUpdatesAutomatically = false // Set to false if you want continuous updates
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 5.0
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("New Lcoation \(UUID())")
        userPosition = CLLocationCoordinate2D(latitude: locations.last?.coordinate.latitude ?? 0.0, longitude: locations.last?.coordinate.longitude ?? 0.0)
    }
}
