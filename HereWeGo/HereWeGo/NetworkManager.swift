//
//  NetworkManager.swift
//  HereWeGo
//
//  Created by Ian Hoyos on 1/30/24.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = URL(string: "http://172.20.10.08:3000")!

    private init() {}

    func createTrip(trip: Trip, completion: @escaping (Result<createTripResponse, Error>) -> Void) {
        let endpoint = baseURL.appendingPathComponent("/createTrip")
        var request = URLRequest(url: endpoint)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            request.httpBody = try JSONEncoder().encode(trip)
        } catch {
            print("Error encoding JSON")
            completion(.failure(error))
            return
        }

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                // Handle missing data error
                return
            }
            do {
                let createResponse = try JSONDecoder().decode(createTripResponse.self, from: data)
                completion(.success(createResponse))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
