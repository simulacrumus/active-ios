//
//  FavoriteActivityType.swift
//  Active
//
//  Created by Emrah on 2022-12-24.
//

import Foundation
import SwiftUI

struct FavoriteActivityType:Codable, Identifiable, Hashable {
    var id:Int
    var activityType:ActivityType
}
