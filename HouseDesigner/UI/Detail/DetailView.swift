//
//  DetailView.swift
//  HouseDesigner
//
//  Created by Max on 03.03.2025.
//

import SwiftUI

struct DetailView: View {
    let furnitureItem: FurnitureCellData

    var body: some View {
        VStack {
            SceneDetailsView(sceneString: furnitureItem.furniture3dTitle)
                .ignoresSafeArea()
            
//            Text(furnitureItem.title)
//                .font(.largeTitle)
//                .foregroundColor(.white)
//            
//            Text(CurrencyFormatter.shared.format(price: Double(furnitureItem.price)))
//                .font(.plusJakartaSansBold22)
//                .padding()
//                .foregroundColor(.white)
        }
                  
//        .padding()
//        .navigationTitle("Details")
    }
}
