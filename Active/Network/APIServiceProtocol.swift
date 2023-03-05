//
//  APIServiceProtocol.swift
//  Active
//
//  Created by Emrah on 2022-12-23.
//

import Foundation

protocol APIServiceProtocol {
    
    func fetchActivityPage(url: URL?, completion: @escaping(Result<ActivityPage, APIError>) -> Void)
    
    func fetchFacilities(url: URL?, completion: @escaping(Result<[Facility], APIError>) -> Void)
    
    func fetchCategories(url: URL?, completion: @escaping(Result<[Category], APIError>) -> Void)
    
    func fetchActivityTypes(url: URL?, completion: @escaping(Result<[ActivityType], APIError>) -> Void)
    
    func fetchFacility(url: URL?, completion: @escaping(Result<Facility, APIError>) -> Void)
    
}
