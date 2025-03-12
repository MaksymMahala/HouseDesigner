//
//  ProfileView.swift
//  HouseDesigner
//
//  Created by Max on 11.03.2025.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Spacer()

                Button {
                    
                } label: {
                    ZStack(alignment: .topTrailing) {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .foregroundStyle(Color.primary)
                        
                        Button {
                            withAnimation {
                                
                            }
                        } label: {
                            Image(systemName: "pencil")
                                .foregroundStyle(Color.white)
                                .padding(10)
                                .background(Color.blue)
                                .clipShape(Circle())
                        }
                    }
                }
                
                Spacer()
            }
            
            HStack {
                Spacer()
                Text(viewModel.email)
                    .foregroundStyle(Color.primary)
                    .font(Font.plusJakartaSansBold22)
                Spacer()
            }
            
            settingsList
        }
        .padding(.top)
    }
    
    private var settingsList: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(viewModel.settingsList, id: \.self) { index in
                    Text(index)
                        .padding()
                }
                .padding(.leading)
                .foregroundStyle(Color.primary)
                .font(Font.plusJakartaSansBold17)
            }
        }
        .padding(.top)
    }
}

#Preview {
    ProfileView()
}
