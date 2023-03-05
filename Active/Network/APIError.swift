//
//  APIError.swift
//  Active
//
//  Created by Emrah on 2022-12-23.
//

import Foundation

enum APIError: Error, CustomStringConvertible {
    case badURL
    case badResponse(statusCode: Int)
    case url(URLError?)
    case parsing(DecodingError?)
    case unknown
    
    var localizedDescription: String {
        // user feedback
        switch self {
            case .badURL, .parsing, .unknown:
                return "Sorry, something went wrong"
            case .badResponse(_):
                return "Sorry, the connection failed"
            case .url(let error):
                return error?.localizedDescription ?? "Something went wrong"
        }
    }
    
    var description: String {
        //info for debugging
        switch self {
            case .unknown: return "Unknown Error"
            case .badURL: return "Invalid URL"
            case .url(let error):
                return error?.localizedDescription ?? "URL Session Error"
            case .parsing(let error):
                return "Parsing Error \(error?.localizedDescription ?? "")"
            case .badResponse(statusCode: let statusCode):
                return "Bad Response With Status Code \(statusCode)"
        }
    }
}
