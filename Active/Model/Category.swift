//
//  Category.swift
//  Active
//
//  Created by Emrah on 2022-12-13.
//

import Foundation

struct Category: Codable, Identifiable, Hashable{
    var id:Int
    var title:String
    var key:String
    var activityTypes:[ActivityType]
    
    static func getCategoryImage(for category:String)-> String{
        switch category{
        case "swimming":
            return "figure.pool.swim"
        case "skating":
            return "figure.hockey"
        case "fitness":
            return "figure.cooldown"
        case "sports":
            return "figure.tennis"
        default:
            return ""
        }
    }
    
    static func sample()-> Category{
        return Category(
            id: 1,
            title: "Swimming",
            key: "swimminng",
            activityTypes: [
                ActivityType(
                    id: 1,
                    title: "Lane Swim",
                    category: "Swimming",
                    key: "laneswim",
                    activityCount: 23
                ),
                ActivityType(
                    id: 2,
                    title: "Public Swim",
                    category: "Swimming",
                    key: "publicswim",
                    activityCount: 10
                )
            ]
        )
    }
}
