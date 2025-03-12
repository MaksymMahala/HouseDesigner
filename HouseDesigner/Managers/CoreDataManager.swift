//
//  CoreDataManager.swift
//  HouseDesigner
//
//  Created by Max on 11.03.2025.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    static let shared = CoreDataManager()
    let persistentContainer: NSPersistentContainer
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "Model") // Replace "Model" with your actual model name
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
    }
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // User Registration
    func registerUser(email: String, password: String, name: String) -> Bool {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@", email)
        
        do {
            let existingUsers = try context.fetch(fetchRequest)
            if !existingUsers.isEmpty {
                return false
            }
            
            let user = User(context: context)
            user.email = email
            user.password = password
            user.name = name
            
            try context.save()
            return true
        } catch {
            print("Failed to save user: \(error)")
            return false
        }
    }
    
    // User Login
    func loginUser(email: String, password: String) -> Bool {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@ AND password == %@", email, password)
        
        do {
            let users = try context.fetch(fetchRequest)
            return !users.isEmpty // If the user exists, return true
        } catch {
            print("❌ Failed to fetch user: \(error)")
            return false
        }
    }
    
    // User Validation
    func validateUser(email: String, password: String) -> Bool {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@ AND password == %@", email, password)
        
        do {
            let users = try context.fetch(fetchRequest)
            return !users.isEmpty
        } catch {
            print("Failed to fetch user: \(error)")
            return false
        }
    }
    
    // Add Favorite Item
    func addFavorite(id: Int64, name: String, price: Double, userEmail: String, image: String) {
        let favorite = Favorites(context: context)
        favorite.id = id
        favorite.name = name
        favorite.price = price
        favorite.userEmail = userEmail // Associate with user
        favorite.image = image
        
        saveContext()
    }
    
    func fetchFavorites(for userEmail: String) -> [Favorites] {
        let fetchRequest: NSFetchRequest<Favorites> = Favorites.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "userEmail == %@", userEmail)
        
        do {
            let favorites = try context.fetch(fetchRequest)
            return favorites
        } catch {
            print("❌ Failed to fetch favorites: \(error)")
            return []
        }
    }
    
    func removeFavorite(id: Int64, userEmail: String) {
        let fetchRequest: NSFetchRequest<Favorites> = Favorites.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d AND userEmail == %@", id, userEmail)
        
        do {
            let favorites = try context.fetch(fetchRequest)
            for favorite in favorites {
                context.delete(favorite)
            }
            saveContext()
        } catch {
            print("❌ Failed to delete favorite: \(error)")
        }
    }
    
    func removeAllFavorites(for userEmail: String) {
        let fetchRequest: NSFetchRequest<Favorites> = Favorites.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "userEmail == %@", userEmail)
        
        do {
            let favorites = try context.fetch(fetchRequest)
            for favorite in favorites {
                context.delete(favorite)
            }
            saveContext()
        } catch {
            print("❌ Failed to delete all favorites: \(error)")
        }
    }
    
    // Save Context
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("❌ Failed to save context: \(error)")
            }
        }
    }
}
