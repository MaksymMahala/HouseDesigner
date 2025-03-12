//
//  UserDefaultsManager.swift
//  HouseDesigner
//
//  Created by Max on 11.03.2025.
//

import Foundation

class UserDefaultsManager {
    
    private enum Keys {
        static let userEmail = "userEmail"
        static let userPassword = "userPassword"
        static let isLoggedIn = "isLoggedIn"
    }
    
    // Save user's email and login status in UserDefaults
    static func saveUserData(email: String, password: String) {
        UserDefaults.standard.set(email, forKey: Keys.userEmail)
        UserDefaults.standard.set(password, forKey: Keys.userPassword)
        UserDefaults.standard.set(true, forKey: Keys.isLoggedIn)
    }
    
    // Retrieve saved email from UserDefaults
    static func getUserEmail() -> String? {
        return UserDefaults.standard.string(forKey: Keys.userEmail)
    }
    
    static func getUserPassword() -> String? {
        return UserDefaults.standard.string(forKey: Keys.userPassword)
    }
    
    // Retrieve login status from UserDefaults
    static func isUserLoggedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: Keys.isLoggedIn)
    }
    
    // Clear user data from UserDefaults
    static func clearUserData() {
        UserDefaults.standard.removeObject(forKey: Keys.userEmail)
        UserDefaults.standard.set(false, forKey: Keys.isLoggedIn)
    }
}
