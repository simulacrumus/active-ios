//
//  FacilityViewModel.swift
//  Active
//
//  Created by Emrah on 2022-12-30.
//

import Foundation
import CoreLocation

class FacilityViewModel: API{
    @Published var facilities = [Facility]()
    @Published var facility:Facility? = nil
    @Published var sort:String = "distance"
    @Published var searchTerm:String = ""
    @Published var activityType:String = ""
    @Published var fetchState: FetchState = .idle
    @Published var dataState: DataState = .initial
    
    private let locationManager = CLLocationManager()

    override convenience init() {
        self.init(activityType: "")
    }
    
    init(activityType:String) {
        self.activityType = activityType
        super.init()

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        $searchTerm
          .dropFirst()
          .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
          .sink { [weak self] term in
              self?.fetchState = .idle
              self?.fetchFacilities(forQuery: term.trim())
          }
          .store(in: &subscriptions)
        
        $sort
            .dropFirst()
            .sink{ [weak self] sortOption in
                self?.fetchState = .idle
                self?.fetchFacilities(forSort: sortOption)
            }
            .store(in: &subscriptions)
        
        $activityType
            .dropFirst()
            .sink{ [weak self] actvtyType in
                self?.fetchState = .idle
                self?.fetchFacilities(forActivityType: actvtyType)
            }
            .store(in: &subscriptions)
        
        fetch()
    }
    
    init(facilityKey:String){
        super.init()
        fetch(for: facilityKey)
    }
    
    func fetch(){
        locationManager.startUpdatingLocation()
        let url = getURL(forQuery: self.searchTerm, forSort: self.sort, forActivityType: self.activityType)
        fetch(url: url)
        locationManager.stopUpdatingLocation()
    }
    
    private func fetchFacilities(forQuery query:String){
        let url = getURL(forQuery: query, forSort: self.sort, forActivityType: self.activityType)
        fetch(url: url)
    }
    
    private func fetchFacilities(forSort sort:String){
        let url = getURL(forQuery: self.searchTerm, forSort: sort, forActivityType: self.activityType)
        fetch(url: url)
    }
    
    private func fetchFacilities(forActivityType activityType:String){
        let url = getURL(forQuery: self.searchTerm, forSort: self.sort, forActivityType: activityType)
        fetch(url: url)
    }
    
    private func fetch(url: URL){
        self.fetchState = .loading
        service.fetchFacilities(url: url) { result in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    self.fetchState = .error(error.description)
                    self.dataState = .error(error.description)
                case .success(let facilities):
                    self.facilities = facilities
                    self.fetchState = .idle
                    self.dataState = facilities.isEmpty ? .empty : .ok
                }
            }
        }
    }
    
    private func fetch(for facilityKey:String){
        var components = URLComponents()
        components.scheme = self.scheme
        components.port = self.port
        components.host = self.host
        components.queryItems = [
            URLQueryItem(name: "key", value: self.apiKey),
            URLQueryItem(name: "lat", value: self.userLocation.lastKnownLocation.lat.description),
            URLQueryItem(name: "lng", value: self.userLocation.lastKnownLocation.lng.description)
        ]
        components.path = "\(self.defaultPath)/facilities/\(facilityKey)"
        
        guard let url = components.url else {
            return
        }
        
        service.fetchFacility(url: url) { result in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    self.dataState = .error(error.description)
                    self.fetchState = .error(error.description)
//                    print(error)
                case .success(let facility):
//                    print("- Facility load sucess -")
                    self.facility = facility
                }
            }
        }
    }
    
    private func getURL(forQuery query:String, forSort sort:String, forActivityType activityType:String) -> URL{
        var components = URLComponents()
        components.scheme = self.scheme
        components.port = self.port
        components.host = self.host
        components.queryItems = [
            URLQueryItem(name: "key", value: self.apiKey),
            URLQueryItem(name: "lat", value: self.userLocation.lastKnownLocation.lat.description),
            URLQueryItem(name: "lng", value: self.userLocation.lastKnownLocation.lng.description),
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "sort", value: sort)
        ]
        
        if activityType.isEmpty {
            components.path = "\(self.defaultPath)/facilities"
        } else {
            components.path = "\(self.defaultPath)/types/\(activityType)/facilities"
        }
//        print(components)
        return components.url!
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation.updateLastKnownLocation(locations.last ?? userLocation.getLastKnownLocation())
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways{
            manager.startUpdatingLocation()
            userLocation.updateLastKnownLocation(locationManager.location ?? userLocation.getLastKnownLocation())
            fetch()
            manager.stopUpdatingLocation()
        }
    }
}
