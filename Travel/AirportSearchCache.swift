//
//  AirportSearchCache.swift
//  Travel
//
//  Created by Hal Mueller on 10/3/19.
//  Copyright © 2019 Around. All rights reserved.
//

import UIKit

class AirportSearchCache: NSObject {
    private var searchResults: [String: [Airport]] = [:]
    
    // FIXME: this cache can grow to infinite size.
    func save(key: String, result: [Airport]) {
        searchResults[key] = result
    }
    
    func lookUp(key: String) -> [Airport]? {
        if let foundResult = searchResults[key] {
            return foundResult
        }
        return nil
    }
    
    func clear() {
        searchResults = [:]
    }
}
