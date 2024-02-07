//
//  UserDefaultsManager.swift
//  HereWeGo
//
//  Created by Ian Hoyos on 2/7/24.
//

import SwiftUI
import Combine
import ManagedSettings

class UserDefaultsManager: ObservableObject {
    static let shared = UserDefaultsManager()

//    private let userDefaults: UserDefaults
    private let sharedUserDefaults = UserDefaults(suiteName: "group.com.rotammi.www")!
    private var cancellables: Set<AnyCancellable> = []
    
    //-------------------------//
    // MARK: Application States Begin
    //-------------------------//
    
    @Published var appState: String? {
        didSet {
            sharedUserDefaults.set(appState, forKey: Keys.appState)
        }
    }
    
    @Published var didBeginOnboarding: Bool {
        didSet {
            sharedUserDefaults.set(didBeginOnboarding, forKey: Keys.didBeginOnboarding)
        }
    }
    
    @Published var didReachPermissions: Bool {
        didSet {
            sharedUserDefaults.set(didReachPermissions, forKey: Keys.didReachPermissions)
        }
    }
    
    @Published var didCompleteOnboarding: Bool {
        didSet {
            sharedUserDefaults.set(didCompleteOnboarding, forKey: Keys.didCompleteOnboarding)
        }
    }
    
    @Published var tripStarted: Bool {
        didSet {
            sharedUserDefaults.set(tripStarted, forKey: Keys.tripStarted)
        }
    }
    
    //-------------------------//
    // MARK: Application States End
    //-------------------------//
    
    //-------------------------//
    // MARK: Navigation States Begin
    //-------------------------//
    
    @Published var isNavigatingToHome: Bool {
        didSet {
            sharedUserDefaults.set(isNavigatingToHome, forKey: Keys.isNavigatingToHome)
        }
    }
    
    //-------------------------//
    // MARK: Navigation States End
    //-------------------------//

    
    //------------------//
    // MARK: User Info Begin
    //------------------//
    
    @Published var userId: String? {
        didSet {
            sharedUserDefaults.set(userId, forKey: Keys.userId)
        }
    }
    
    @Published var firstName: String? {
        didSet {
            sharedUserDefaults.set(firstName, forKey: Keys.firstName)
        }
    }
    
    @Published var lastName: String? {
        didSet {
            sharedUserDefaults.set(lastName, forKey: Keys.lastName)
        }
    }
    
    @Published var dateOfBirthName: Date? {
        didSet {
            sharedUserDefaults.set(dateOfBirthName, forKey: Keys.dateOfBirthName)
        }
    }
    
    @Published var email: String? {
        didSet {
            sharedUserDefaults.set(email, forKey: Keys.email)
        }
    }
    
    //------------------//
    // MARK: User Info End
    //------------------//
    
    private init() {
//        userDefaults = UserDefaults.standard

        //-- Load initial values --//
        
        //Application States ---------------------
        appState = sharedUserDefaults.string(forKey: Keys.appState)
        didBeginOnboarding = sharedUserDefaults.bool(forKey: Keys.didBeginOnboarding)
        didReachPermissions = sharedUserDefaults.bool(forKey: Keys.didReachPermissions)
        didCompleteOnboarding = sharedUserDefaults.bool(forKey: Keys.didCompleteOnboarding)
        tripStarted = sharedUserDefaults.bool(forKey: Keys.tripStarted)
        
        // Navigation State ----------------------
        isNavigatingToHome = sharedUserDefaults.bool(forKey: Keys.isNavigatingToHome)
                
        // User Info -----------------------------
        userId = sharedUserDefaults.string(forKey: Keys.userId)
        firstName = sharedUserDefaults.string(forKey: Keys.firstName)
        lastName = sharedUserDefaults.string(forKey: Keys.lastName)
        dateOfBirthName = sharedUserDefaults.object(forKey: Keys.dateOfBirthName) as? Date
        email = sharedUserDefaults.string(forKey: Keys.email)
        //-------------------------//

    }

    // MARK: - Storage Keys

    public struct Keys {
        //Application States ---------------------
        static let appState = "appState"
        static let didBeginOnboarding = "didBeginOnboarding"
        static let didReachPermissions = "didReachPermissions"
        static let didCompleteOnboarding = "didCompleteOnboarding"
        static let tripStarted = "tripStarted"
       
        
        //Navigation States ---------------------
        static let isNavigatingToHome = "isNavigatingToHome"
                
        //User Info ---------------------
        static let userId = "userId"
        static let firstName = "firstName"
        static let lastName = "lastName"
        static let dateOfBirthName = "dateOfBirthName"
        static let email = "email"
        
        // Add more keys as needed
    }

    // MARK: - Custom Accessors

    func clearUserData() {
        //Application States ---------------------
        sharedUserDefaults.removeObject(forKey: Keys.appState)
        sharedUserDefaults.removeObject(forKey: Keys.didBeginOnboarding)
        sharedUserDefaults.removeObject(forKey: Keys.didReachPermissions)
        sharedUserDefaults.removeObject(forKey: Keys.didCompleteOnboarding)
        sharedUserDefaults.removeObject(forKey: Keys.tripStarted)
        
        //Navigation States ---------------------
        sharedUserDefaults.removeObject(forKey: Keys.isNavigatingToHome)
        
        //User Info ---------------------
        sharedUserDefaults.removeObject(forKey: Keys.userId)
        sharedUserDefaults.removeObject(forKey: Keys.firstName)
        sharedUserDefaults.removeObject(forKey: Keys.lastName)
        sharedUserDefaults.removeObject(forKey: Keys.dateOfBirthName)
        sharedUserDefaults.removeObject(forKey: Keys.email)
    }
}
