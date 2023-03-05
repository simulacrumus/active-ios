//
//  CategoryViewModel.swift
//  Active
//
//  Created by Emrah on 2022-12-23.
//

import Foundation
import Combine

class CategoryViewModel: API{
    @Published var categories = [Category]()
    @Published var facility:String = ""
    @Published var fetchState: FetchState = .idle
    @Published var dataState: DataState = .initial

    override init() {
        
        super.init()
        
        $facility
            .dropFirst()
            .sink{ [weak self] facilty in
                self?.fetchState = .idle
                self?.fetchCategories(for: facilty)
            }
            .store(in: &subscriptions)
        
        fetch()
    }
    
    init(facility:String) {
        
        self.facility = facility
        
        super.init()
        
        $facility
            .dropFirst()
            .sink{ [weak self] facilty in
                self?.fetchState = .idle
                self?.fetchCategories(for: facilty)
            }
            .store(in: &subscriptions)
        
        fetch()
    }
    
    func fetch(){
        let url = getURL(for: self.facility)
        fetch(url: url)
    }
    
    private func fetchCategories(for facility:String){
        let url = getURL(for: facility)
        fetch(url: url)
    }
    
    private func fetch(url: URL){
        self.fetchState = .loading
        service.fetchCategories(url: url) { result in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    self.fetchState = .error(error.description)
                    self.dataState = .error(error.description)
                case .success(let categories):
                    self.categories = categories
                    self.fetchState = .idle
                    self.dataState = categories.isEmpty ? .empty : .ok
                }
            }
        }
    }
    
    private func getURL(for facility:String) -> URL{
        var components = URLComponents()
        components.scheme = self.scheme
        components.port = self.port
        components.host = self.host
        components.queryItems = [
            URLQueryItem(name: "key", value: self.apiKey)
        ]
        
        if facility.isEmpty {
            components.path = "\(self.defaultPath)/categories"
        } else {
            components.path = "\(self.defaultPath)/facilities/\(facility)/categories"
        }

        return components.url!
    }
}
