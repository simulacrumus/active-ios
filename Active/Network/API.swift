//
//  API.swift
//  Active
//
//  Created by Emrah on 2023-01-14.
//

import Foundation
import CoreLocation
import MapKit
import SwiftUI
import Combine

class API: NSObject, ObservableObject, CLLocationManagerDelegate{
    let service:APIServiceProtocol = APIService()
    let apiKey:String = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as! String
    let scheme:String = Bundle.main.object(forInfoDictionaryKey: "API_SCHEME") as! String
    let port:Int = 8080
    let defaultPath:String = Bundle.main.object(forInfoDictionaryKey: "API_DEFAULT_PATH") as! String
    let host:String = Bundle.main.object(forInfoDictionaryKey: "API_HOST") as! String
    var subscriptions = Set<AnyCancellable>()
    var userLocation:UserLocationDefault=UserLocationDefault()
}
