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
}
