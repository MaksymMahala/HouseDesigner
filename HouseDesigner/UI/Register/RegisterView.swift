//
//  RegisterView.swift
//  HouseDesigner
//
//  Created by Max on 11.03.2025.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var navigationEnv: NavigationEnv
    @EnvironmentObject var navigationManager: NavigationLoginManager
    @StateObject private var viewModel = RegisterViewModel()
    
    var body: some View {
        VStack {
            Text("Sign In")
                .foregroundStyle(Color.black)
                .font(Font.plusJakartaSansBold32)
            
            Text(viewModel.message)
                .foregroundColor(.red)
                .padding()
            
            Spacer()
            
            fields
            
            Spacer()
            
            bottomButton
            
            
            Spacer()
            
            HStack {
                Text("Already have account? ")
                    .font(.plusJakartaSansRagular15)
                    .foregroundStyle(Color.black)
                Button {
                    navigationManager.resetToHome()
                } label: {
                    Text ("SIGN IN")
                        .font(.plusJakartaSansBold15)
                        .foregroundStyle(Color.black)
                }
            }
            .padding(.top, 30)
            
            Button {
                
            } label: {
                Text("Skip for Now >>")
                    .font(.plusJakartaSansBold15)
                    .foregroundStyle(Color.blue.opacity(0.8))
                    .padding(.top,  5)
                    .padding(.horizontal)
            }
            
            Spacer()
        }
        .padding(.horizontal, 80)
    }
    
    @ViewBuilder
    private var fields: some View {
        VStack(alignment: .leading) {
            ZStack {
                TextField("Name", text: $viewModel.name)
                    .background {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(lineWidth: 2)
                            .frame(width: 280, height: 50)
                            .foregroundStyle(Color.primary)
                    }
            }
            .padding(.vertical)
            
            ZStack {
                TextField("Email", text: $viewModel.email)
                    .background {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(lineWidth: 2)
                            .frame(width: 280, height: 50)
                            .foregroundStyle(Color.primary)
                    }
            }
            .padding(.vertical)
            
            ZStack {
                HStack {
                    if viewModel.showPassword {
                        TextField("Password", text: $viewModel.password)
                    } else {
                        SecureField("Password", text: $viewModel.password)
                    }
                    
                    Button {
                        viewModel.showPassword.toggle()
                    } label: {
                        Image(systemName: "eye")
                            .font(.headline)
                            .foregroundStyle(Color.primary)
                    }
                }
                .background {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(lineWidth: 2)
                        .frame(width: 280, height: 50)
                        .foregroundStyle(Color.primary)
                }
            }
            .padding(.vertical)
            
            HStack {
                Divider()
                    .frame(width: 100, height: 2)
                    .background(Color.lightGray)
                
                Text("OR")
                    .foregroundStyle(Color.lightGray)
                    .font(.plusJakartaSansBold15)
                
                Divider()
                    .frame(width: 100, height: 2)
                    .background(Color.lightGray)
            }
            .padding(.top, 30)
            
            HStack {
                Button {
                    
                } label: {
                    Image(.google)
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 2)
                        }
                        .padding()
                }
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image(.facebook)
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 2)
                        }
                        .padding()
                }
            }
            .padding(.vertical)
        }
    }
    
    private var bottomButton: some View {
        Button("Continue") {
            withAnimation {
                viewModel.register(navigationEnv: navigationEnv)
            }
        }
        .font(Font.nunitoSans_7pt_CondensedBold20)
        .padding()
        .frame(width: 270, height: 50)
        .background(Color.primary)
        .foregroundColor(.white)
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

#Preview {
    RegisterView()
}
