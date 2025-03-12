//
//  RegisterViewModel.swift
//  HouseDesigner
//
//  Created by Max on 11.03.2025.
//

import SwiftUI
import CoreData

class RegisterViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var message: String = ""
    @Published var showPassword: Bool = false

    func register(navigationEnv: NavigationEnv) {
        let success = CoreDataManager.shared.registerUser(email: email, password: password, name: name)
        message = success ? "Registration Successful!" : "Email already in use."
        if success {
            navigationEnv.isLogin = true
        }
    }
    
    func login(navigationEnv: NavigationEnv) {
        let success = CoreDataManager.shared.loginUser(email: email, password: password)
        
        if success {
            navigationEnv.isLogin = true
            UserDefaultsManager.saveUserData(email: email, password: password)
        } else {
            message = "Invalid email or password"
        }
    }
}

