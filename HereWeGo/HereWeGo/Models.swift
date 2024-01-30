//
//  Models.swift
//  HereWeGo
//
//  Created by Ian Hoyos on 1/30/24.
//

import Foundation

struct Trip: Codable {
    var tripId: String
    var userId: String
    var pickupLocation: String
    var dropoffLocation: String
    var tripStatus: String
    // Add other properties as needed
    
    // default init for testing
    init() {
        self.tripId = UUID().uuidString
        self.userId = "user123"
        self.pickupLocation = "LocationA"
        self.dropoffLocation = "LocationB"
        self.tripStatus = "open"
    }
}

struct createTripResponse: Codable {
    var tripId: String
}
