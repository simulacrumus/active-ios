//
//  SortAndFilterViewModel.swift
//  Active
//
//  Created by Emrah on 2022-12-15.
//

import Foundation

struct SortAndFilterModel:Identifiable{
    var id:Int
    var title:String
    var subtitle:String
    var option:String
}

struct SortOptions{
    var facilitySortOptions:[SortAndFilterModel] = [
        SortAndFilterModel(id: 1, title: "Sort: Distance", subtitle: "Distance", option: "distance")
    ]
    
    var activitySortOptions:[SortAndFilterModel] = [
        SortAndFilterModel(id: 0, title: "Sort", subtitle: "Default", option: "id"),
        SortAndFilterModel(id: 1, title: "Sort: Title", subtitle: "Title", option: "title"),
        SortAndFilterModel(id: 2, title: "Sort: Distance", subtitle: "Distance", option: "distance"),
        SortAndFilterModel(id: 3, title: "Sort: Time", subtitle: "Time", option: "time")
    ]
    
    var activitySortOptionsForType:[SortAndFilterModel] = [
        SortAndFilterModel(id: 0, title: "Sort", subtitle: "Default", option: "id"),
        SortAndFilterModel(id: 2, title: "Sort: Distance", subtitle: "Distance", option: "distance"),
        SortAndFilterModel(id: 3, title: "Sort: Time", subtitle: "Time", option: "time")
    ]
    
    var activitySortOptionsForTypeWithFacilitySelected:[SortAndFilterModel] = [
        SortAndFilterModel(id: 1, title: "Sort: Time", subtitle: "Time", option: "time")
    ]
    
    var activitySortOptionsForTypeWithoutFacilitySelected:[SortAndFilterModel] = [
        SortAndFilterModel(id: 1, title: "Sort: Distance", subtitle: "Distance", option: "distance"),
        SortAndFilterModel(id: 2, title: "Sort: Time", subtitle: "Time", option: "time")
    ]
    
    var typeSortOptions:[SortAndFilterModel] = [
        SortAndFilterModel(id: 0, title: "Sort", subtitle: "Default", option: "id"),
        SortAndFilterModel(id: 2, title: "Sort: Popular", subtitle: "Popular", option: "popularity"),
        SortAndFilterModel(id: 3, title: "Sort: Title", subtitle: "Title", option: "title")
    ]
}
