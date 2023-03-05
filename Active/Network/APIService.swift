//
//  APIService.swift
//  Active
//
//  Created by Emrah on 2022-12-23.
//

import Foundation
import SwiftUI


struct APIService: APIServiceProtocol {

    func fetch<T: Decodable>(_ type: T.Type, url: URL?, completion: @escaping(Result<T,APIError>) -> Void) {
        guard let url = url else {
            let error = APIError.badURL
            completion(Result.failure(error))
            return
        }
        let task = URLSession.shared.dataTask(with: url) {(data , response, error) in
            
            if let error = error as? URLError {
                completion(Result.failure(APIError.url(error)))
            }else if  let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completion(Result.failure(APIError.badResponse(statusCode: response.statusCode)))
            }else if let data = data {
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(type, from: data)
                    completion(Result.success(result))
                    
                }catch {
                    completion(Result.failure(APIError.parsing(error as? DecodingError)))
                }
            }
        }
        task.resume()
    }
    
    func fetchActivityPage(url: URL?, completion: @escaping (Result<ActivityPage, APIError>) -> Void) {
        fetch(ActivityPage.self, url: url, completion: completion)
    }
    
    func fetchFacilities(url: URL?, completion: @escaping (Result<[Facility], APIError>) -> Void) {
        fetch([Facility].self, url: url, completion: completion)
    }
    
    func fetchCategories(url: URL?, completion: @escaping (Result<[Category], APIError>) -> Void) {
        fetch([Category].self, url: url, completion: completion)
    }
    
    func fetchActivityTypes(url: URL?, completion: @escaping (Result<[ActivityType], APIError>) -> Void) {
        fetch([ActivityType].self, url: url, completion: completion)
    }
    
    func fetchFacility(url: URL?, completion: @escaping (Result<Facility, APIError>) -> Void) {
        fetch(Facility.self, url: url, completion: completion)
    }
}
