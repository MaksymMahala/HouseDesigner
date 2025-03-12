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
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        Text("House Designer")
                            .font(Font.plusJakartaSansBold22)
                            .foregroundStyle(Color.primary)
                        
                        Spacer()
                        
                        HStack {
                            searchButton
                            
                            cartButton
                        }
                    }
                    .padding(.horizontal)
                    
                    Button {
                        
                    } label: {
                        Image(.banner)
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal)
                    }
                    
                    categories
                    
                    VStack(alignment: .leading) {
                        ZStack {
                            Color.blue.opacity(0.5)
                                .cornerRadius(15)
                            
                            VStack {
                                HStack {
                                    titleBox
                                    
                                    Spacer()
                                }
                                .padding(.horizontal)
                                
                                Spacer()
                                
                                furniturePhoto3D
                                
                                Spacer()
                                Spacer()
                            }
                        }
                        .padding(.horizontal)
                        
                        main
                    }
                }
            }
            .onAppear {
                homeViewModel.fetchData()
            }
            .onDisappear {
                homeViewModel.stopTimer()
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
            HStack {
                Button {
                    homeViewModel.decrementCurrentFurniture3DTitle()
                } label: {
                    Image(systemName: "arrow.left")
                        .foregroundStyle(Color.black)
                        .font(.headline)
                        .padding(.vertical, 20)
                        .padding(.horizontal, 5)
                        .background(Color.lightWhite)
                        .clipShape(CustomRoundedShape(cornerRadius: 20, roundLeftCorners: false))
                }
                
                if let furnitureItem = homeViewModel.furnitureItem {
                    NavigationLink(destination: FurnitureDetailView(furnitureItem: furnitureItem)) {
                        SceneView(sceneString: homeViewModel.furnitureItems.isEmpty ? Constants.Default.default3DTitleFurniture : homeViewModel.furnitureItems[homeViewModel.currentFurnitureTitle3DIndex].furniture3dTitle)
                            .frame(maxWidth: .infinity)
                            .frame(height: 260)
                    }
                }
                
                Button {
                    homeViewModel.incrementCurrentFurniture3DTitle()
                } label: {
                    Image(systemName: "arrow.right")
                        .foregroundStyle(Color.black)
                        .font(.headline)
                        .padding(.vertical, 20)
                        .padding(.horizontal, 5)
                        .background(Color.lightWhite)
                        .clipShape(CustomRoundedShape(cornerRadius: 20, roundLeftCorners: true))
                }

            }
            
            HStack {
                if let price = homeViewModel.furnitureItem?.price {
                    Text("$\(String(format: "%.0f", price))")
                        .font(Font.headline)
                        .foregroundStyle(Color.privatePriomaryColorBlack(colorScheme: colorScheme))
                        .padding()
                        .padding(.horizontal)
                        .background(Color.privatePriomaryColorWhite(colorScheme: colorScheme))
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                }
                
                Spacer()
                
                Button {
                    homeViewModel.isFavorite.toggle()
                    if let furnitureItem = homeViewModel.furnitureItem {
                        CoreDataManager.shared.addFavorite(id: Int64(furnitureItem.id), name: furnitureItem.title, price: furnitureItem.price, userEmail: UserDefaultsManager.getUserEmail() ?? "invalid email", image: furnitureItem.furniture3dTitle)
                    }
                } label: {
                    Image(systemName: homeViewModel.isFavorite ? "heart.fill" : "heart")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .padding()
                        .foregroundStyle(homeViewModel.isFavorite ? Color.green : Color.privatePriomaryColorBlack(colorScheme: colorScheme))
                        .background(Color.privatePriomaryColorWhite(colorScheme: colorScheme))
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
                .foregroundStyle(Color.privatePriomaryColorBlack(colorScheme: colorScheme))
                .padding()
                .background(Color.privatePriomaryColorWhite(colorScheme: colorScheme))
                .clipShape(RoundedRectangle(cornerRadius: 15))
        }
    }
    
    private var searchButton: some View {
        Button(action: {
            withAnimation {
                homeViewModel.isSearch.toggle()
            }
        }) {
            Image(systemName: "magnifyingglass")
                .font(.headline)
                .foregroundStyle(Color.privatePriomaryColorBlack(colorScheme: colorScheme))
                .padding()
                .background(Color.privatePriomaryColorWhite(colorScheme: colorScheme))
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
    }
    
    private var furnitureList: some View {
        let filteredFurniture = homeViewModel.furnitureItems.filter { item in
            homeViewModel.searchText.isEmpty || item.title.lowercased().contains(homeViewModel.searchText.lowercased())
        }

        return LazyVGrid(columns: homeViewModel.gridItems, spacing: 20) {
            ForEach(filteredFurniture, id: \.id) { item in
                NavigationLink(destination: FurnitureDetailView(furnitureItem: item)) {
                    FurnitureCell(furnitureCellData: item, toggleFavoriteAction: {
                        toggleFavorite(for: item)
                        CoreDataManager.shared.addFavorite(id: Int64(item.id), name: item.title, price: item.price, userEmail: UserDefaultsManager.getUserEmail() ?? "invalid email", image: item.furniture3dTitle)
                    })
                }
            }
        }
    }
    
    private func toggleFavorite(for item: FurnitureCellData) {
        if let index = homeViewModel.furnitureItems.firstIndex(where: { $0.id == item.id }) {
            homeViewModel.furnitureItems[index].isFavorite.toggle()
        }
    }
    
    private var categories: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(homeViewModel.categories.indices, id: \.self) { index in
                    Button {
                        withAnimation {
                            homeViewModel.selectedCategories = index
                        }
                    } label: {
                        Text(homeViewModel.categories[index])
                            .foregroundStyle(homeViewModel.selectedCategories == index ? Color.white : Color.black)
                            .padding()
                            .background {
                                homeViewModel.selectedCategories == index ? Color.black : Color.white
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                    }
                }
                .foregroundStyle(Color.black)
                .font(Font.plusJakartaSansBold17)
                .padding(.leading)
            }
        }
        .padding(.vertical, 25)
    }
    
    private var main: some View {
        VStack(alignment: .leading) {
            if homeViewModel.isSearch {
                searchFurniture
            }
            
            Text("Popular")
                .font(Font.plusJakartaSansBold22)
                .foregroundStyle(Color.primary)
                .padding(.horizontal)
            
            if let errorMessage = homeViewModel.errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
                    .padding()
            } else {
                furnitureList
            }
        }
        .padding(.top)
    }
}

#Preview {
    HomeView()
}
