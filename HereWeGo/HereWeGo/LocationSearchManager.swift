//
//  LocationSearchManager.swift
//  HereWeGo
//
//  Created by Ian Hoyos on 2/7/24.
//

import Foundation
import MapKit

class LocationSearchManager: NSObject, ObservableObject, MKLocalSearchCompleterDelegate {
    @Published var searchResults: [MKMapItem] = []
    private var completer = MKLocalSearchCompleter()
    let locationManager = CoreLocationManager.shared

    override init() {
        super.init()
        completer.delegate = self
        completer.resultTypes = [.address, .pointOfInterest]
    }

    func updateSearchResults(for query: String) {
        self.searchResults.removeAll()
        completer.queryFragment = query
    }

    private func fetchDetails(for completion: MKLocalSearchCompletion) {
        let request = MKLocalSearch.Request(completion: completion)
        let search = MKLocalSearch(request: request)
        search.start { [weak self] (response, _) in
            guard let strongSelf = self, let items = response?.mapItems else { return }
            
            // Filter and sort `items` by distance from `userPosition`
            
            DispatchQueue.main.async {
                strongSelf.searchResults.append(items.first ?? MKMapItem())
            }
        }
    }

    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        // Clear previous results
        
        // Fetch details for each completion and sort them by distance
//        completer.results.forEach { fetchDetailsAndSort(for: $0) }
        completer.results.forEach { fetchDetails(for: $0) }
        self.searchResults = searchResults.sorted { item1, item2 in
            let distance1 = item1.placemark.location?.distance(from: CLLocation(latitude: self.locationManager.userPosition?.latitude ?? 0.0, longitude: self.locationManager.userPosition?.longitude ?? 0.0)) ?? Double.greatestFiniteMagnitude
            let distance2 = item2.placemark.location?.distance(from: CLLocation(latitude: self.locationManager.userPosition?.latitude ?? 0.0, longitude: self.locationManager.userPosition?.longitude ?? 0.0)) ?? Double.greatestFiniteMagnitude
            
            return distance1 < distance2
        }
    }
}

