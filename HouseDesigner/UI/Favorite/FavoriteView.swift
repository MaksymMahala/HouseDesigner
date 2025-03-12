//
//  FavoriteView.swift
//  HouseDesigner
//
//  Created by Max on 11.03.2025.
//

import SwiftUI

class FavoriteViewModel: ObservableObject {
    @Published var showAlert = false
    @Published var alertMessage = ""
    var email: String
    
    init(email: String = UserDefaultsManager.getUserEmail() ?? "invalid email") {
        self.email = email
    }
    
    func favorites() -> [Favorites] {
        let favorites = CoreDataManager.shared.fetchFavorites(for: email)
        return favorites
    }
    
    func removeAllFavorites() {
        CoreDataManager.shared.removeAllFavorites(for: email)
        alertMessage = "All favorites have been removed!"
        showAlert = true
    }
    
    func removeById(indexSet: IndexSet) {
        for index in indexSet {
            let favorite = favorites()[index]
            CoreDataManager.shared.removeFavorite(id: favorite.id, userEmail: email)
            alertMessage = "Selected favorite(s) have been removed!"
            showAlert = true
        }
    }
}

struct FavoriteView: View {
    @StateObject private var favoritesViewModel = FavoriteViewModel()
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Favorites furniture")
                    .font(Font.plusJakartaSansBold22)
                    .foregroundStyle(Color.primary)
                    .padding(.horizontal)
                
                Spacer()
                
                Button {
                    withAnimation {
                        favoritesViewModel.removeAllFavorites()
                    }
                } label: {
                    Image(systemName: "trash.fill") // Trash icon
                        .foregroundStyle(Color.white)
                        .padding()
                        .background(Color.black)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding()
                }
            }
            
            VStack {
                List {
                    ForEach(favoritesViewModel.favorites(), id: \.id) { index in
                        HStack {
                            SceneView(sceneString: index.image ?? "invalid image")
                                .frame(width: 150, height: 100)
                                .background(Color.lightGray)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .padding(5)
                            
                            Spacer()
                            VStack(alignment: .leading, spacing: 10) {
                                Text(index.name ?? "")
                                    .font(Font.plusJakartaSansBold17)
                                    .foregroundStyle(Color.black)
                                Text("$\(String(format: "%.0f", index.price))")
                            }
                            .frame(width: 150, alignment: .leading)
                            .padding(.horizontal)
                        }
                        .padding(4)
                    }
                    .onDelete { indexSet in
                        withAnimation {
                            favoritesViewModel.removeById(indexSet: indexSet)
                        }
                    }
                }
            }
        }
        .alert(isPresented: $favoritesViewModel.showAlert) {
            Alert(title: Text("Success"), message: Text(favoritesViewModel.alertMessage), dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    FavoriteView()
}
