import Foundation

class WebSocketManager {
    private var webSocketTask: URLSessionWebSocketTask?
    private let url = URL(string: "ws://172.20.10.8:3000")!
    private var isConnected: Bool = false

    func connect() {
        guard !isConnected else { return }

        webSocketTask = URLSession.shared.webSocketTask(with: url)
        webSocketTask?.resume()
        receiveMessage()
        isConnected = true
        
        // Call identifyAsCustomer right after establishing the connection
        identifyAsCustomer()
    }

    func disconnect() {
        guard isConnected else { return }

        webSocketTask?.cancel(with: .goingAway, reason: nil)
        isConnected = false
    }
    
    private func identifyAsCustomer() {
        // Modify as needed, perhaps based on some app state or user input
        // userId would be substituted with unique device id stored in User Defaults
        let identificationMessage = ["type": "identify", "role": "customer", "userId": "MyUniqueIdForNow"] as [String : Any]
        guard let messageData = try? JSONSerialization.data(withJSONObject: identificationMessage, options: []),
              let messageString = String(data: messageData, encoding: .utf8) else {
            print("Error: Unable to serialize identification message to JSON string")
            return
        }

        sendMessage(messageString)
    }

    private func receiveMessage() {
        webSocketTask?.receive { [weak self] result in
            switch result {
            case .failure(let error):
                print("Error in receiving message: \(error)")
            case .success(let message):
                switch message {
                case .string(let text):
                    print("Received string: \(text)")
                case .data(let data):
                    print("Received data: \(data)")
                default:
                    break
                }

                self?.receiveMessage()
            }
        }
    }

    func sendMessage(_ message: String) {
        webSocketTask?.send(.string(message)) { error in
            if let error = error {
                print("Error in sending message: \(error)")
            }
        }
    }
}
