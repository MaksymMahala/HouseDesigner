//
//  RegisterView.swift
//  HouseDesigner
//
//  Created by Max on 11.03.2025.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var navigationEnv: NavigationEnv
    @StateObject private var navigationManager = NavigationLoginManager()
    @StateObject private var viewModel = RegisterViewModel()
    
    var body: some View {
        NavigationStack(path: $navigationManager.path) {
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
                    Text("Don’t have account? ")
                        .font(.plusJakartaSansRagular15)
                        .foregroundStyle(Color.black)
                    
                    Button {
                        navigationManager.navigate(to: .register)
                    } label: {
                        Text ("SIGN UP")
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
            .navigationDestination(for: LoginRoute.self) { route in
                RouterView(route: route)
            }
        }
        .environmentObject(navigationManager)
    }
    
    @ViewBuilder
    private var fields: some View {
        VStack(alignment: .leading) {
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
                Button {
                    
                } label: {
                    Text("forget password?")
                        .foregroundStyle(Color.blue)
                        .font(Font.plusJakartaSansBold15)
                }
            }
            .padding(.vertical, 4)
            
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
                viewModel.login(navigationEnv: navigationEnv)
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
