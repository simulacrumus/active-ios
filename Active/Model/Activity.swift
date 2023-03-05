//
//  Activity.swift
//  Active
//
//  Created by Emrah on 2022-11-25.
//

import Foundation

struct Activity: Codable, Identifiable, Hashable{
    var id: Int
    var title: String
    var time: String
    var facility: Facility
    var category: String
    var type: String
    var reservationURL: String
    var isAvailable: Bool
    var lastUpdated: String
    
    func getShortTime()-> String{
        let date:Date = Date.getDate(from: self.time)
        return "\(date.getNameOfTheWeek()), \(date.getTime())"
    }
    
    func getMediumTime()-> String{
        let date:Date = Date.getDate(from: self.time)
        return date.getMediumDateTime()
    }
    
    func getLongTime()-> String{
        let date:Date = Date.getDate(from: self.time)
        return date.getLongDateTime()
    }
    
    func getRegularTime()-> String{
        let date:Date = Date.getDate(from: self.time)
        return date.getRegularDateTime()
    }
    
    func getLastUpdated() -> String{
        let date:Date = Date.getDate(from: self.lastUpdated)
        return date.getRelativeDateTime()
    }
    
    func getAvailibility() -> String{
        return self.isAvailable ? "Available" : "Full"
    }
    
    static func sample() -> Activity {
        let facility = Facility.sample()
        return Activity(
            id: 1,
            title: "Aquafit General - Deep",
            time: "Date()",
            facility: facility,
            category: "Swimming",
            type: "Aqua",
            reservationURL: "Test reservation link",
            isAvailable: true,
            lastUpdated: "Date()"
        )
    }
}

