//
//  Option.swift
//  Active
//
//  Created by Emrah on 2022-12-23.
//

import Foundation

struct Option:Identifiable, Hashable{
    var id:Int
    var key:String
    var title:String
    var subtitle:String
    
    static func facilitySortOptions()->[Option]{
        return [
            Option(id: -1, key: "id", title: "Sort", subtitle: "Sort By"),
            Option(id: 1, key: "distance", title: "Sort: Distance", subtitle: "Distance"),
            Option(id: 2, key: "title", title: "Sort: Alphabetically", subtitle: "Alphabetically")
        ]
    }
    
    static func activitySortOptions()->[Option]{
        return [
            Option(id: -1, key: "id", title: "Sort", subtitle: "Sort By"),
            Option(id: 1, key: "distance", title: "Sort: Distance", subtitle: "Distance"),
            Option(id: 2, key: "time", title: "Sort: Time", subtitle: "Time")
        ]
    }
    
    static func placeholderFacilityOption()->Option{
        return Option(id: 0, key: "", title: "Facility", subtitle: "Select Facility")
    }
    
    static func defaultFacilitySortOption()->Option{
        return Option(id: 1, key: "distance", title: "Sort: Distance", subtitle: "Distance")
    }
    
    static func defaultActivityTypeSortOption()->Option{
        return Option(id: 1, key: "distance", title: "Sort: Distance", subtitle: "Distance")
    }
}
