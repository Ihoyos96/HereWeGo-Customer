//
//  HereWeGoApp.swift
//  HereWeGo
//
//  Created by Ian Hoyos on 1/30/24.
//

import SwiftUI

@main
struct HereWeGoApp: App {
    @Environment(\.scenePhase) var scenePhase
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @StateObject var userDefaults = UserDefaultsManager.shared
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
        .onChange(of: scenePhase) { oldScenePhase, newScenePhase in
            switch newScenePhase {
            case .active:
                // App is active
                userDefaults.appState = "Active"
            case .inactive:
                // App is inactive
                userDefaults.appState = "Inactive"
            case .background:
                // App is in the background
                userDefaults.appState = "Background"
            @unknown default:
                // Handle any future cases if necessary
                break
            }
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    var window: UIWindow?
    let userDefaults = UserDefaultsManager.shared

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        if userDefaults.userId == nil {
            userDefaults.userId = UUID().uuidString
            userDefaults.firstName = "Ian"
            userDefaults.lastName = "Hoyos"
            
            var dateComponents = DateComponents()
            dateComponents.year = 1993
            dateComponents.month = 9
            dateComponents.day = 17

            let userCalendar = Calendar.current // User's current calendar
            let dateOfBirth = userCalendar.date(from: dateComponents)
            userDefaults.dateOfBirthName = dateOfBirth
            userDefaults.email = "ianEmail@gmail.com"
        }
        
        print("Finished launching")
        return true
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//        if userDefaults.didCompleteOnboarding && userDefaults.internetAccessAuthorized {
//            let backend = BackendManager()
//            backend.storeDevice(deviceToken: deviceToken, retryCount: 24)
//            backend.logEvent(eventType: "START", timestamp: Date().description, retryCount: 24)
//        }
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // Handle remote notifications as needed
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
       // Handle the error appropriately
       print("Failed to register for remote notifications: \(error)")
    }

    func applicationWillTerminate(_ application: UIApplication) {
        print("Terminating Gracefully...")
        
        // Perform any cleanup or termination tasks
    }
}
