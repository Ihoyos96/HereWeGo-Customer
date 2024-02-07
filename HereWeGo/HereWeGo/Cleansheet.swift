
//
//  LocationSearchManager.swift
//  HereWeGo
//
//  Created by Ian Hoyos on 2/7/24.
//

import SwiftUI
import MapKit

class LocationSearchService: NSObject, ObservableObject, MKLocalSearchCompleterDelegate {
    var completer: MKLocalSearchCompleter
    @Published var searchResults = [MKLocalSearchCompletion]()

    override init() {
        completer = MKLocalSearchCompleter()
        super.init()
        completer.delegate = self
    }
    
    func search(query: String) {
        completer.queryFragment = query
    }

    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
    }
}

