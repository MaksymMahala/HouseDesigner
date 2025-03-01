//
//  FurnitureCell.swift
//  HouseDesigner
//
//  Created by Max on 28.02.2025.
//

import SwiftUI

struct FurnitureCellData {
    let id: Int
    let color: Color
    let title: String
    let price: Int
    var isFavorite: Bool
    var furniture3dTitle: String
}

struct FurnitureCell: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var furnitureCellData: FurnitureCellData

    var body: some View {
        ZStack {
            VStack {
                ZStack(alignment: .topTrailing) {
                    SceneView(sceneString: furnitureCellData.furniture3dTitle)
                        .frame(width: 100, height: 100)
                        .padding()
                        .edgesIgnoringSafeArea(.all)
                    
                    Button {
                        furnitureCellData.isFavorite.toggle()
                    } label: {
                        Image(systemName: furnitureCellData.isFavorite ? "heart.fill" : "heart")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 15, height: 15)
                            .padding()
                            .foregroundStyle(furnitureCellData.isFavorite ? Color.white : Color.privatePriomaryColorBlack(colorScheme: colorScheme))
                            .background(Color.privatePriomaryColorWhite(colorScheme: colorScheme))
                            .clipShape(Circle())
                    }
                    .padding(.leading)
                }
                
                VStack(spacing: 10) {
                    Text(furnitureCellData.title)
                        .foregroundStyle(Color.primary)
                        .font(Font.plusJakartaSansRagular15)
                    
                    Text("$\(furnitureCellData.price)")
                        .foregroundStyle(Color.primary)
                        .font(Font.plusJakartaSansBold15)
                }
            }
        }
        .padding()
        .background(furnitureCellData.color)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
