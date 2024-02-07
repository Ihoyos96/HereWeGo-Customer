//
//  Models.swift
//  HereWeGo
//
//  Created by Ian Hoyos on 1/30/24.
//

import Foundation
import CoreLocation

struct User {
    var userId: String
    var firstName: String
    var lastName: String
    var dateOfBirth: Date?
    
    init(firstName: String, lastName: String) {
        self.userId = UUID().uuidString
        self.firstName = firstName
        self.lastName = lastName
    }
}

struct Trip: Codable {
    var tripId: String?
    var userId: String
    var driverID: String
    var pickupLocation: CLLocationCoordinate2D?
    var dropoffLocation: CLLocationCoordinate2D?
    var tripStatus: String
    // Add other properties as needed
    
    // default init for testing
    init() {
        self.tripId = UUID().uuidString
        self.userId = "user123"
        self.driverID = "Not Assigned"
        self.pickupLocation = CLLocationCoordinate2D()
        self.dropoffLocation = CLLocationCoordinate2D()
        self.tripStatus = "open"
    }
    
    init(userId: String, pickupLocation: CLLocationCoordinate2D, dropoffLocation: CLLocationCoordinate2D) {
        self.tripId = UUID().uuidString
        self.userId = userId
        self.driverID = "Not Assigned"
        self.pickupLocation = pickupLocation
        self.dropoffLocation = dropoffLocation
        self.tripStatus = "open"
    }
}

struct createTripResponse: Codable {
    var tripId: String
}


// MARK: - Extensions

extension CLLocationCoordinate2D: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let latitude = try container.decode(Double.self, forKey: .latitude)
        let longitude = try container.decode(Double.self, forKey: .longitude)
        self.init(latitude: latitude, longitude: longitude)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
    }

    enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
    }
}
