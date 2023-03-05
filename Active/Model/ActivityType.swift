//
//  ActivityType.swift
//  Active
//
//  Created by Emrah on 2022-12-08.
//

import Foundation

struct ActivityType: Codable, Identifiable, Hashable{
    var id:Int
    var title:String
    var category:String
    var key:String
    var activityCount:Int
    
    static func sample()-> ActivityType{
        return ActivityType(
            id: 1,
            title: "Lane Swim",
            category: "Swimming",
            key: "laneswim",
            activityCount: 23
        )
    }
}
