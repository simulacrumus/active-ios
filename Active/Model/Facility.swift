//
//  Facility.swift
//  Active
//
//  Created by Emrah on 2022-12-07.
//

import Foundation

struct Facility: Codable, Identifiable, Hashable{
    var id:Int
    var key:String
    var title:String
    var address:String
    var phone:String
    var email:String
    var url:String
    var lat:Double
    var lng:Double
    var distance:Double
    
    func getDistance() -> String{
        return self.distance < 1000.0 ?
        String(format: "%.0f m", self.distance) :
        String(format: "%.1f km", self.distance / 1000)
    }
    
    func getAddress() -> String{
        return String(self.address.split(separator: "Ottawa").first!)
    }
    
    static func sample()->Facility{
        return Facility(
            id: 1,
            key: "pinecrest",
            title: "Pinecrest Recreation Centre",
            address: "1490 Youville Drive Ottawa ON K1C 2X8 Canada",
            phone: "613-580-9600",
            email: "sports@ottawa.ca",
            url: "https://ottawa.ca/en/recreation-and-parks/recreation-facilities/facility-listing/bob-macquarrie-recreation-complex-orleans",
            lat: 45.4661876,
            lng: -75.5449273,
            distance: 13.2)
    }
}
