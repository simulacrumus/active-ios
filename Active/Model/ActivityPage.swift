//
//  ActivityPage.swift
//  Active
//
//  Created by Emrah on 2022-12-08.
//

import Foundation

struct ActivityPage: Codable{
    var content:[Activity]
    var last:Bool
    var totalElements:Int
    var totalPages:Int
}
