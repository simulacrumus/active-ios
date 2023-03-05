//
//  ActivityTypeViewModel.swift
//  Active
//
//  Created by Emrah on 2022-12-23.
//

import Foundation
import Combine

class ActivityTypeViewModel: API{
    @Published var activityTypes = [ActivityType]()
    @Published var sort:String = "title"
    @Published var searchTerm:String = ""
    @Published var state: FetchState = .idle
    
    override init() {
        super.init()

        $searchTerm
          .dropFirst()
          .sink { [weak self] term in
              self?.state = .idle
              self?.fetchActivityTypes(forQuery: term.trim())
          }
          .store(in: &subscriptions)
        
        $sort
            .dropFirst()
            .debounce(for: .seconds(0.0), scheduler: RunLoop.main)
            .sink{ [weak self] sortOption in
                self?.state = .idle
                self?.fetchActivityTypes(forSort: sortOption)
            }
            .store(in: &subscriptions)
        // No need to fetch activity types when the object is initialzed
        // Fetch activity types only when user starts typing for search
    }
    
    init(sort:String) {
        self.sort = sort
        super.init()
        self.fetch()
    }
    
    func fetch(){
        let url = getURL(forQuery: self.searchTerm, forSort: self.sort)
        fetch(url: url)
    }
    
    private func fetchActivityTypes(forSort sortOption:String){
        let url = getURL(forQuery: self.searchTerm, forSort: sortOption)
        fetch(url: url)
    }
    
    private func fetchActivityTypes(forQuery searchTerm:String){
        let url = getURL(forQuery: searchTerm, forSort: self.sort )
        fetch(url: url)
    }
    
    private func fetch(url: URL){
        service.fetchActivityTypes(url: url) { result in
            DispatchQueue.main.async {
                switch result {
                    case .failure(let error):
                        self.state = .error(error.localizedDescription)
                    case .success(let activityTypes):
                        self.activityTypes = activityTypes
                        self.state = .idle
                }
            }
        }
    }
    
    private func getURL(forQuery searchTerm:String, forSort sort:String) -> URL{
        var components = URLComponents()
        components.scheme = self.scheme
        components.port = self.port
        components.host = self.host
        components.queryItems = [
            URLQueryItem(name: "key", value: self.apiKey),
            URLQueryItem(name: "q", value: searchTerm),
            URLQueryItem(name: "sort", value: sort)
        ]
        components.path = "\(self.defaultPath)/types"

        return components.url!
    }
}
