//
//  HereWeGoApp.swift
//  HereWeGo
//
//  Created by Ian Hoyos on 1/30/24.
//

import SwiftUI

@main
struct HereWeGoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
