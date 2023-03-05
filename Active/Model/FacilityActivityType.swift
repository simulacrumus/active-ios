//
//  FacilityActivityType.swift
//  Active
//
//  Created by Emrah on 2022-12-23.
//

import Foundation

struct FacilityActivityType:Codable, Identifiable, Hashable {
    var id:String
    var facility:Facility
    var activityType:ActivityType
}
