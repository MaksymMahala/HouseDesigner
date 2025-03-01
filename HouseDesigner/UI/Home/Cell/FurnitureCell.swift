//
//  FurnitureCell.swift
//  HouseDesigner
//
//  Created by Max on 28.02.2025.
//

import SwiftUI

struct FurnitureCell: View {
    @Environment(\.colorScheme) var colorScheme
    var furnitureCellData: FurnitureCellData
    var toggleFavoriteAction: () -> Void
    
    var body: some View {
        ZStack {
            VStack {
                ZStack(alignment: .topTrailing) {
                    SceneView(sceneString: furnitureCellData.furniture3dTitle)
                        .frame(width: 100, height: 100)
                        .padding()
                        .edgesIgnoringSafeArea(.all)
                    
                    Button {
                        toggleFavoriteAction()
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
                        .multilineTextAlignment(.center)
                        .foregroundStyle(Color.primary)
                        .font(Font.plusJakartaSansRagular15)
                    
                    Text("$\(furnitureCellData.price)")
                        .foregroundStyle(Color.primary)
                        .font(Font.plusJakartaSansBold15)
                }
            }
        }
        .padding()
        .frame(width: 170, height: 230)
        .background(furnitureCellData.uiColor)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
