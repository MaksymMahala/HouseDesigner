//
//  ProfileViewModel.swift
//  HouseDesigner
//
//  Created by Max on 11.03.2025.
//

import Foundation
import CoreData

class ProfileViewModel: ObservableObject {
    @Published var email: String = ""
    var settingsList = ["Orders", "Shipping Address", "Payment Method", "My Reviews", "Setting", "Terms & Conditions", "Logout"]
    
    init() {
        self.fetchUserProfile()
    }
    
    func fetchUserProfile() {
        let email = UserDefaultsManager.getUserEmail()
        let password = UserDefaultsManager.getUserPassword()

        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        
        do {
            let users = try context.fetch(fetchRequest)
            
            for user in users {
                if user.email == email && user.password == password {
                    DispatchQueue.main.async { [weak self] in
                        self?.email = user.email ?? ""
                    }
                }
            }
        } catch {
            print("❌ Failed to fetch user: \(error)")
        }
    }
}
