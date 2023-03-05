//
//  LocationManager.swift
//  Active
//
//  Created by Emrah on 2022-12-16.
//


import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    @Published var lastKnownLocation: CLLocation?
    
    init(lastKnownLocation: CLLocation? = nil) {
        self.lastKnownLocation = manager.location
        super.init()
        startUpdating()
    }
    
    func startUpdating() {
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func stopUpdating(){
        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.last
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways{
            manager.startUpdatingLocation()
        }
    }
}
