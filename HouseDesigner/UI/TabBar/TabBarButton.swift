//
//  TabBarButton.swift
//  HouseDesigner
//
//  Created by Max on 28.02.2025.
//

import SwiftUI

struct TabBarButton: View {
    var image: String
    var title: String
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        VStack {
            Image(systemName: image)
                .font(.system(size: 24))
                .foregroundColor(isSelected ? .white : .gray.opacity(0.8))
            
            if isSelected {
                Circle()
                    .foregroundStyle(Color.white)
                    .frame(width: 10, height: 10)
            }
        }
        .padding(5)
        .padding(.horizontal)
        .onTapGesture {
            withAnimation {
                action()
            }
        }
    }
}
