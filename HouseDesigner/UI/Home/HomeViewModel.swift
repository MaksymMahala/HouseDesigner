//
//  HomeViewModel.swift
//  HouseDesigner
//
//  Created by Max on 28.02.2025.
//

import Foundation
import SwiftUICore

class HomeViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var isFavorite = false
    @Published var furnitureCellData: [FurnitureCellData] = [
        FurnitureCellData(id: 1, color: Color.green, title: "Bed", price: 120, isFavorite: false, furniture3dTitle: "Sofa-green.dae"),
        FurnitureCellData(id: 2, color: Color.gray, title: "Sofa", price: 80, isFavorite: false, furniture3dTitle: "dyvan.dae"),
        FurnitureCellData(id: 3, color: Color.blue, title: "Chief", price: 140, isFavorite: false, furniture3dTitle: "dyvan.dae")

    ]
    
    var filteredFurniture: [String] {
        if searchText.isEmpty {
            return furnitureCellData.map { $0.title }
        } else {
            return furnitureCellData.map { $0.title }.filter { $0.localizedCaseInsensitiveContains(searchText) }
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
