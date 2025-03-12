//
//  DetailView.swift
//  HouseDesigner
//
//  Created by Max on 03.03.2025.
//

import SwiftUI

struct FurnitureDetailView: View {
    let furnitureItem: FurnitureCellData
    @Environment(\.presentationMode) var presentationMode
    @State private var scaleFactor: Float = 1.0 // Default scale

    var body: some View {
        ZStack {
            SceneDetailsView(sceneString: furnitureItem.furniture3dTitle, scaleFactor: $scaleFactor)
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Button(action: {
                        withAnimation {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(.black)
                            .padding()
                            .background(Color.white)
                            .clipShape(Circle())
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                }
                
                Spacer()
                
                HStack {
                    Text(furnitureItem.title) //add emoji
                        .foregroundStyle(Color.black)
                        .font(Font.plusJakartaSansRagular17)
                        .padding(20)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .padding(.horizontal)
                    
                    HStack {
                        Button(action: {
                            scaleFactor = max(0.5, scaleFactor - 0.1)
                        }) {
                            Text("-")
                                .font(.headline)
                                .foregroundStyle(Color.black)
                                .frame(width: 30, height: 30)
                                .background(Color.gray.opacity(0.2))
                                .clipShape(Circle())
                        }
                        
                        Button(action: {
                            scaleFactor = min(3.0, scaleFactor + 0.1)
                        }) {
                            Text("+")
                                .font(.headline)
                                .foregroundStyle(Color.black)
                                .frame(width: 30, height: 30)
                                .background(Color.gray.opacity(0.2))
                                .clipShape(Circle())
                        }
                    }
                    .padding()
                    .background(Color.black)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .padding(.bottom, 6)
                }
                .padding(.top)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}
