//
//  WebSocketManager.swift
//  HereWeGo
//
//  Created by Ian Hoyos on 1/30/24.
//

import Foundation

class WebSocketManager {
    private var webSocketTask: URLSessionWebSocketTask?
    
    func connect() {
        let url = URL(string: "ws://10.0.0.8:3000")!
        webSocketTask = URLSession.shared.webSocketTask(with: url)
        webSocketTask?.resume()

        receiveMessage()
    }

    func disconnect() {
        webSocketTask?.cancel(with: .normalClosure, reason: nil)
    }

    private func receiveMessage() {
        webSocketTask?.receive { [weak self] result in
            switch result {
            case .failure(let error):
                print("Error in receiving message: \(error)")
            case .success(.string(let str)):
                print("Received string: \(str)")
                // Handle received string
                self?.receiveMessage() // Continue receiving messages
            case .success(.data(let data)):
                print("Received data: \(data)")
                // Handle received data
                self?.receiveMessage() // Continue receiving messages
            default:
                break
            }
        }
    }

    // Add function to send messages if needed
}
