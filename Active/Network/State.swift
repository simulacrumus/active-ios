//
//  State.swift
//  Active
//
//  Created by Emrah on 2022-12-25.
//

import Foundation

enum FetchState: Comparable {
    case idle
    case loading
    case loadedAll
    case error(String)
}

enum DataState: Comparable{
    case initial
    case empty
    case ok
    case error(String)
}
