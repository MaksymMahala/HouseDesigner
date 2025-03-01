//
//  ContentView.swift
//  HouseDesigner
//
//  Created by Max on 28.02.2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var homeViewModel: HomeViewModel = HomeViewModel()
    @Environment(\.screenSize) var screenSize
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .topLeading) {
                Color.gray.opacity(0.6)
                    .frame(height: 450)
                    .clipShape(RoundedRectangle(cornerRadius: 40))
                    .ignoresSafeArea()
                
                VStack(alignment: .leading) {
                    VStack {
                        HStack {
                            titleBox
                            
                            Spacer()
                            
                            cartButton
                        }
                        .padding(.horizontal)
                        
                        furniturePhoto3D
                    }
                    
                    ScrollView(showsIndicators: false) {
                        
                        searchFurniture
                        
                        furnitureList
                    }
                }
            }
            .withScreenSize()
        }
    }
    
    private var titleBox: some View {
        VStack {
            Text("Find the best")
                .foregroundStyle(Color.primary)
                .font(Font.dynamicFontPlusJakartaSansRagular(for: screenSize))
            + Text(" ")
            + Text("furniture! 🛋️")
                .foregroundStyle(Color.primary)
                .font(Font.dynamicFontPlusJakartaSansBold(for: screenSize))
        }
        .frame(width: 200, height: 90)
        .multilineTextAlignment(.leading)
    }
    
    private var furniturePhoto3D: some View {
        ZStack(alignment: .bottom) {
            //Furniture 3D !!!
            
            SceneView(sceneString: "dyvan.dae")
            
            HStack {
                Text("$230")
                    .font(Font.headline)
                    .foregroundStyle(Color.privatePriomaryColorBlack(colorScheme: colorScheme))
                    .padding()
                    .padding(.horizontal)
                    .background(Color.privatePriomaryColorWhite(colorScheme: colorScheme))
                    .clipShape(RoundedRectangle(cornerRadius: 25))

                Spacer()
                
                Button {
                    homeViewModel.isFavorite.toggle()
                } label: {
                    Image(systemName: homeViewModel.isFavorite ? "heart.fill" : "heart")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .padding()
                        .foregroundStyle(homeViewModel.isFavorite ? Color.green : Color.privatePriomaryColorWhite(colorScheme: colorScheme))
                        .background(Color.privatePriomaryColorBlack(colorScheme: colorScheme))
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 20)
        }
    }
    
    private var cartButton: some View {
        Button(action: {
            withAnimation {
                print("cart tapped")
            }
        }) {
            Image(systemName: "cart")
                .font(.headline)
                .foregroundStyle(Color.privatePriomaryColorWhite(colorScheme: colorScheme))
                .padding()
                .background(Color.privatePriomaryColorBlack(colorScheme: colorScheme))
                .clipShape(RoundedRectangle(cornerRadius: 15))
        }
    }
    
    private var searchFurniture: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
                .padding(10)
            
            TextField("Search furniture...", text: $homeViewModel.searchText)
                .foregroundStyle(.black)
                .frame(height: 30)
                .textFieldStyle(PlainTextFieldStyle())
                .padding(10)
            
            if !homeViewModel.searchText.isEmpty {
                Button {
                    homeViewModel.searchText = ""
                } label: {
                    Text("cancel")
                        .font(Font.headline)
                        .foregroundStyle(Color.red)
                        .padding(10)
                }
            }
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding()
        .padding(.top)
    }
    
    private var furnitureList: some View {
        ScrollView {
            let gridItems = [GridItem(.flexible()), GridItem(.flexible())]

            LazyVGrid(columns: gridItems, spacing: 20) {
                ForEach(homeViewModel.filteredFurniture.indices, id: \.self) { item in
                    FurnitureCell(furnitureCellData: $homeViewModel.furnitureCellData[item])
                        .padding(.horizontal)
                }
            }
            .padding()
        }
    }
}

#Preview {
    HomeView()
}
