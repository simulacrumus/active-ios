//
//  MapAnnotatedItem.swift
//  Active
//
//  Created by Emrah on 2022-12-30.
//

import Foundation
import CoreLocation

struct MapAnnotatedItem: Identifiable {
    let id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
}
