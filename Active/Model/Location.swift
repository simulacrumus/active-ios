//
//  Location.swift
//  Active
//
//  Created by Emrah on 2022-12-30.
//

import Foundation

struct Location: Codable, Identifiable, Hashable{
    var id = UUID()
    var lat:Double
    var lng:Double
    var title:String
}
