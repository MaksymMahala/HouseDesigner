//
//  FurnitureCellData.swift
//  HouseDesigner
//
//  Created by Max on 01.03.2025.
//

import SwiftUI

struct FurnitureCellData: Codable {
    var id: Int
    var color: String
    let title: String
    let price: Int
    var isFavorite: Bool
    var furniture3dTitle: String
    
    var uiColor: Color {
        return Color(hex: color)
    }
}
