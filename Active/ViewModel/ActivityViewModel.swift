//
//  ActivitiesViewModel.swift
//  Active
//
//  Created by Emrah on 2022-12-02.
//

import Foundation
import CoreLocation

class ActivityViewModel: API{
    
    @Published var activities = [Activity]()
    @Published var facility:String = String()
    @Published var sort:String = QueryParam.distance.rawValue
    @Published var searchTerm:String = String()
    @Published var activityType:String = String()
    @Published var available:String = String()
    @Published var fetchState: FetchState = .idle
    @Published var dataState: DataState = .initial
    
    private let locationManager = CLLocationManager()
    private let size:Int = 10
    private var page:Int = Int.zero
    
    override convenience init() {
        self.init(facility: String(), activityType: String())
    }
    
    convenience init(activityType:String) {
        self.init(facility: String(), activityType: activityType)
    }
    
    init(facility:String, activityType:String) {
        self.facility = facility
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
              self?.page = Int.zero
              self?.fetchState = .idle
              self?.fetchActivities(forQuery: term.trim())
          }
          .store(in: &subscriptions)
        
        $sort
            .dropFirst()
            .sink{ [weak self] sortOption in
                self?.page = Int.zero
                self?.fetchState = .idle
                self?.fetchActivities(forSort: sortOption)
            }
            .store(in: &subscriptions)
        
        $activityType
            .dropFirst()
            .sink{ [weak self] actvtyType in
                self?.page = Int.zero
                self?.fetchState = .idle
                self?.fetchActivities(forActivityType: actvtyType)
            }
            .store(in: &subscriptions)
        
        $facility
            .dropFirst()
            .sink{ [weak self] faclty in
                self?.page = Int.zero
                self?.fetchState = .idle
                self?.activities = []
                self?.fetchActivities(forFacility: faclty)
            }
            .store(in: &subscriptions)
        
        $available
            .dropFirst()
            .sink{ [weak self] availble in
                self?.page = Int.zero
                self?.fetchState = .idle
                self?.fetchActivities(forAvailibility: availble)
            }
            .store(in: &subscriptions)
        
        fetch()
        
        locationManager.stopUpdatingLocation()
    }
    
    deinit {
        locationManager.stopUpdatingLocation()
    }
    
    func fetch(){
        self.page = Int.zero
        let url = getURL(forQuery: self.searchTerm, forSort: self.sort, forFacility: self.facility, forActivityType: self.activityType, forAvailibility: self.available)
        fetch(url: url)
    }
    
    private func fetchActivities(forAvailibility available:String){
        self.page = Int.zero
        let url = getURL(forQuery: self.searchTerm, forSort: self.sort, forFacility: self.facility, forActivityType: self.activityType, forAvailibility: available)
        fetch(url: url)
    }
    
    private func fetchActivities(forQuery query:String){
        self.page = Int.zero
        let url = getURL(forQuery: query, forSort: self.sort, forFacility: self.facility, forActivityType: self.activityType, forAvailibility: self.available)
        fetch(url: url)
    }
    
    private func fetchActivities(forFacility facility:String){
        self.page = Int.zero
        let url = getURL(forQuery: self.searchTerm, forSort: self.sort, forFacility: facility, forActivityType: self.activityType, forAvailibility: self.available)
        fetch(url: url)
    }
    
    private func fetchActivities(forSort sort:String){
        self.page = Int.zero
        let url = getURL(forQuery: self.searchTerm, forSort: sort, forFacility: self.facility, forActivityType: self.activityType, forAvailibility: self.available)
        fetch(url: url)
    }
    
    private func fetchActivities(forActivityType activityType:String){
        self.page = Int.zero
        let url = getURL(forQuery: self.searchTerm, forSort: self.sort, forFacility: self.facility, forActivityType: activityType, forAvailibility: self.available)
        fetch(url: url)
    }
    
    private func fetch(url: URL){
        self.fetchState = .loading
        service.fetchActivityPage(url: url) { result in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    self.fetchState = .error(error.description)
                    self.dataState = .error(error.description)
                case .success(let activityPage):
                    self.activities = []
                    self.activities = activityPage.content
                    self.fetchState = activityPage.last ? .loadedAll : .idle
                    self.dataState = activityPage.totalElements == Int.zero ? .empty : .ok
                }
            }
        }
    }
    
    func fetchNextPage(){
        guard fetchState == .idle else {
            return
        }
        self.fetchState = .loading
        self.page += 1
        let url = getURL(forQuery: self.searchTerm, forSort: self.sort, forFacility: self.facility, forActivityType: self.activityType, forAvailibility: self.available)
        service.fetchActivityPage(url: url) { [unowned self] result in
            DispatchQueue.main.async {
                switch result {
                    case .failure(let error):
                        self.fetchState = .error(error.localizedDescription)
                    case .success(let activityPage):
                        self.activities.append(contentsOf: activityPage.content)
                        self.activities = self.activities.uniqued() // API might response with duplicate items in different pages, which causes strange UI behaviour
                        self.fetchState = activityPage.last ? .loadedAll : .idle
                    self.dataState = activityPage.totalElements == Int.zero ? .empty : .ok
                }
            }
        }
    }
    
    private func getURL(forQuery query:String, forSort sort:String, forFacility facility:String, forActivityType activityType:String, forAvailibility isAvailable:String) -> URL{
        var components = URLComponents()
        components.scheme = self.scheme
        components.port = self.port
        components.host = self.host
        components.queryItems = [
            URLQueryItem(name: QueryParam.key.rawValue, value: self.apiKey),
            URLQueryItem(name: QueryParam.latitude.rawValue, value: self.userLocation.lastKnownLocation.lat.description),
            URLQueryItem(name: QueryParam.longitude.rawValue, value: self.userLocation.lastKnownLocation.lng.description),
            URLQueryItem(name: QueryParam.page.rawValue, value: self.page.description),
            URLQueryItem(name: QueryParam.size.rawValue, value: self.size.description),
            URLQueryItem(name: QueryParam.query.rawValue, value: query),
            URLQueryItem(name: QueryParam.sort.rawValue, value: sort),
            URLQueryItem(name: QueryParam.available.rawValue, value: isAvailable)
        ]
        
        if facility.isEmpty{
            if activityType.isEmpty {
                components.path = "\(self.defaultPath)/\(QueryParam.activities.rawValue)"
            } else {
                components.path = "\(self.defaultPath)/\(QueryParam.activities.rawValue)/\(QueryParam.types.rawValue)/\(activityType)/\(QueryParam.activities.rawValue)"
            }
        } else if activityType.isEmpty {
            components.path = "\(self.defaultPath)/\(QueryParam.facilities.rawValue)/\(facility)/\(QueryParam.activities.rawValue)"
        } else {
            components.path = "\(self.defaultPath)/\(QueryParam.facilities.rawValue)/\(facility)/\(QueryParam.types.rawValue)/\(activityType)/\(QueryParam.activities.rawValue)"
        }
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
