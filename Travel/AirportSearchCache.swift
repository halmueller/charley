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
    private var searchKeys: NSMutableOrderedSet = []
    let maximumSavedSearches = 5 // keep it low for testing, raise it for production
    
    func save(key: String, result: [Airport]) {
        searchResults[key] = result
    }
    
    func lookUp(key: String) -> [Airport]? {
        if key == "" {
            return nil
        }
        // remove the key from ordered set, then add it, so latest search is always at the end
        searchKeys.remove(key)
        searchKeys.add(key)
        // if we've cached too many searches, remove the least recently used one, which is at index 0
        if searchKeys.count > maximumSavedSearches {
            searchKeys.removeObject(at: 0)
        }
        print(searchKeys)
        if let foundResult = searchResults[key] {
            return foundResult
        }
        return nil
    }
    
    func clear() {
        searchResults = [:]
    }
}
