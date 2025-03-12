//
//  HomeViewModel.swift
//  HouseDesigner
//
//  Created by Max on 28.02.2025.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var isFavorite = false
    @Published var furnitureItems: [FurnitureCellData] = []
    @Published var errorMessage: String? = nil
    @Published var currentFurnitureTitle3DIndex = 0
    @Published var isSearch = false
    
    @Published var selectedCategories: Int = 0 {
        didSet {
            fetchData()
        }
    }
    
    let categories = ["Furniture", "Living", "Bedroom"]
    let gridItems = [GridItem(.flexible()), GridItem(.flexible())]
    var furnitureItem: FurnitureCellData?
    
    private var timer: Timer?
    private let furnitureService: FurnitureServiceProtocol
    
    init(furnitureService: FurnitureServiceProtocol = FurnitureService.shared) {
        self.furnitureService = furnitureService
    }
    
    deinit {
        timer?.invalidate()
    }
      
    func fetchData() {
        furnitureService.fetchFurnitureData { result in
            switch result {
            case .success(let items):
                DispatchQueue.main.async {
                    self.furnitureItems = self.filterItemsByCategory(items: items)
                    self.furnitureItem = items[self.currentFurnitureTitle3DIndex]
                    self.currentFurnitureTitle3DIndex = 0 // Start at first item
                    self.startTimer() // Start changing titles when data is loaded
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func filterItemsByCategory(items: [FurnitureCellData]) -> [FurnitureCellData] {
        switch selectedCategories {
        case 0: // For "Furniture" category
            return items.filter { $0.category == "Furniture" }
        case 1: // For "Lighting" category
            return items.filter { $0.category == "LivingRoom" }
        case 2: // For "Appliances" category
            return items.filter { $0.category == "BedRoom" }
        default:
            return items
        }
    }
    
    func startTimer() {
        guard !furnitureItems.isEmpty else { return } // Ensure list is not empty
        
        timer?.invalidate() // Stop previous timer if exists
        
        timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { _ in
            DispatchQueue.main.async {
                if !self.furnitureItems.isEmpty {
                    self.currentFurnitureTitle3DIndex = (self.currentFurnitureTitle3DIndex + 1) % self.furnitureItems.count
                    self.furnitureItem = self.furnitureItems[self.currentFurnitureTitle3DIndex]
                    print("Timer updated index: \(self.currentFurnitureTitle3DIndex)") // Debugging
                }
            }
        }
        
        print("Timer started!")
    }
    
    func stopTimer() {
        timer?.invalidate()
    }
    
    func incrementCurrentFurniture3DTitle() {
        currentFurnitureTitle3DIndex += 1
    }
    
    func decrementCurrentFurniture3DTitle() {
        if currentFurnitureTitle3DIndex == 0 {
            currentFurnitureTitle3DIndex = 0
        } else {
            currentFurnitureTitle3DIndex -= 1
        }
    }
}
