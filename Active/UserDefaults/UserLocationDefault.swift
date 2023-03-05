//
//  UserLocationDefault.swift
//  Active
//
//  Created by Emrah on 2023-02-19.
//

import Foundation
import CoreLocation

class UserLocationDefault{
    
    let defaults = UserDefaults.standard
    var lastKnownLocation:Location
    private let OTTTAWA_CITY_CENTRE_LOCATION:Location = Location(lat: 45.42001, lng: -75.68954, title: "Ottawa City Centre")
    
    init() {
        let decoder = PropertyListDecoder()
        
        if let data = defaults.value(forKey: "User_Last_Known_Location") as? Data {
            let location = try? decoder.decode(Location.self, from: data)
            self.lastKnownLocation = location ?? OTTTAWA_CITY_CENTRE_LOCATION
        } else {
            self.lastKnownLocation = OTTTAWA_CITY_CENTRE_LOCATION
        }
    }
    
    func refresh(){
        let decoder = PropertyListDecoder()
        
        if let data = defaults.value(forKey: "User_Last_Known_Location") as? Data {
            let location = try? decoder.decode(Location.self, from: data)
            self.lastKnownLocation = location ?? OTTTAWA_CITY_CENTRE_LOCATION
        } else {
            self.lastKnownLocation = OTTTAWA_CITY_CENTRE_LOCATION
        }
    }
    
    func updateLastKnownLocation(_ newLocation:CLLocation){
        self.lastKnownLocation.lat = newLocation.coordinate.latitude
        self.lastKnownLocation.lng = newLocation.coordinate.longitude
        let encoder = PropertyListEncoder()
        if let encoded = try? encoder.encode(self.lastKnownLocation) {
            self.defaults.set(encoded, forKey: "User_Last_Known_Location")
        }
        defaults.synchronize()
    }
    
    func getLastKnownLocation()->CLLocation{
        return CLLocation(latitude: self.lastKnownLocation.lat, longitude: self.lastKnownLocation.lng)
    }
}
