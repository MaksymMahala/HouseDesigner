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
    
    @Published var selectedfurniture: FurnitureCellData?

    private let furnitureService: FurnitureServiceProtocol
    
    init(furnitureService: FurnitureServiceProtocol = FurnitureService.shared) {
        self.furnitureService = furnitureService
    }
    
    let gridItems = [GridItem(.flexible()), GridItem(.flexible())]
    
      
    func fetchData() {
        furnitureService.fetchFurnitureData { result in
            switch result {
            case .success(let items):
                DispatchQueue.main.async {
                    self.furnitureItems = items
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}


struct ContentView1: View {
    var body: some View {
        SceneView(sceneString: "Sofa-green.dae")
            .frame(width: 300, height: 300)
            .padding(.top, 40)
            .edgesIgnoringSafeArea(.all)
    }
}


struct ContentView2: View {
    var body: some View {
        SceneView(sceneString: "dyvan.dae")
            .frame(width: 400, height: 300)
            .padding(.top, 40)
            .edgesIgnoringSafeArea(.all)
    }
}
