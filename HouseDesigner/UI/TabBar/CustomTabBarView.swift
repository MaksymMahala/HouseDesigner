//
//  CustomTabBarView.swift
//  HouseDesigner
//
//  Created by Max on 28.02.2025.
//

import SwiftUI

struct CustomTabBarView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        VStack {
            ZStack {
                switch selectedTab {
                case 0:
                    HomeView()
                case 1:
                    Text("1")
                default:
                    Text("2")
                }
                
            }
            
            Spacer()
            
            HStack {
                TabBarButton(image: "house.fill", title: "Home", isSelected: selectedTab == 0) {
                    selectedTab = 0
                }
                Spacer()
                TabBarButton(image: "heart.fill", title: "Favourite", isSelected: selectedTab == 1) {
                    selectedTab = 1
                }
                Spacer()
                TabBarButton(image: "person.fill", title: "Profile", isSelected: selectedTab == 2) {
                    selectedTab = 2
                }
            }
            .padding()
            .background(Color.black)
            .clipShape(RoundedRectangle(cornerRadius: 25))
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    CustomTabBarView()
}
