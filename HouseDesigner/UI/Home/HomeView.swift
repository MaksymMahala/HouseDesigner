//
//  ContentView.swift
//  HouseDesigner
//
//  Created by Max on 28.02.2025.
//

import SwiftUI

struct CustomRoundedShape: Shape {
    var cornerRadius: CGFloat
    var roundLeftCorners: Bool

    func path(in rect: CGRect) -> Path {
        var path = Path()

        if roundLeftCorners {
            path.move(to: CGPoint(x: rect.minX, y: rect.minY + cornerRadius))
            path.addArc(center: CGPoint(x: rect.minX + cornerRadius, y: rect.minY + cornerRadius),
                        radius: cornerRadius,
                        startAngle: .degrees(180),
                        endAngle: .degrees(270),
                        clockwise: false)

            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))

            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))

            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addArc(center: CGPoint(x: rect.minX + cornerRadius, y: rect.maxY - cornerRadius),
                        radius: cornerRadius,
                        startAngle: .degrees(90),
                        endAngle: .degrees(180),
                        clockwise: false)

        } else {
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
                   path.addLine(to: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY))
                   
                   path.addArc(center: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY + cornerRadius),
                               radius: cornerRadius,
                               startAngle: .degrees(270),
                               endAngle: .degrees(360),
                               clockwise: false)

                   path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - cornerRadius))
                   
                   path.addArc(center: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY - cornerRadius),
                               radius: cornerRadius,
                               startAngle: .degrees(0),
                               endAngle: .degrees(90),
                               clockwise: false)

                   path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))

                   path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))

        }

        path.closeSubpath()
        return path
    }
}


struct HomeView: View {
    @StateObject private var homeViewModel: HomeViewModel = HomeViewModel()
    @Environment(\.screenSize) var screenSize
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .topLeading) {
                Color.lightGray
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
                    
                    bodyScrolling
                    
                    .padding(.top)
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
                    NavigationLink(destination: DetailView(furnitureItem: furnitureItem)) {
                        SceneView(sceneString: homeViewModel.furnitureItems.isEmpty ? Constants.Default.default3DTitleFurniture : homeViewModel.furnitureItems[homeViewModel.currentFurnitureTitle3DIndex].furniture3dTitle)
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
                    Text("$\(price)")
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
    }
    
    private var furnitureList: some View {
        let filteredFurniture = homeViewModel.furnitureItems.filter { item in
            homeViewModel.searchText.isEmpty || item.title.lowercased().contains(homeViewModel.searchText.lowercased())
        }

        return LazyVGrid(columns: homeViewModel.gridItems, spacing: 20) {
            ForEach(filteredFurniture, id: \.id) { item in
                NavigationLink(destination: DetailView(furnitureItem: item)) {
                    FurnitureCell(furnitureCellData: item, toggleFavoriteAction: {
                        toggleFavorite(for: item)
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
    
    private var bodyScrolling: some View {
        ScrollView {
            searchFurniture
            
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
