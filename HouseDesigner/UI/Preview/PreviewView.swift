//
//  PreviewView.swift
//  HouseDesigner
//
//  Created by Max on 11.03.2025.
//

import SwiftUI

struct PreviewView: View {
    var body: some View {
        ZStack(alignment: .top) {
            ZStack(alignment: .topTrailing) {
                Image(.imageBackgroundRegister)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
                
                Circle()
                    .frame(width: 410, height: 410)
                    .foregroundStyle(Color.white)
                    .offset(y: -120)
            }
            
            VStack(spacing: 5) {
                Text("Welcome")
                    .foregroundStyle(Color.black)
                    .font(.plusJakartaSansBold32)
                
                Text("Why buy it when you can rent it?")
                    .foregroundStyle(Color.black)
                    .font(.plusJakartaSansRagular15)
                
                Button {
                    
                } label: {
                    HStack {
                        Text("Start")
                        
                        Image(systemName: "arrow.right")
                    }
                    .font(Font.nunitoSans_7pt_CondensedBold20)
                    .foregroundStyle(Color.white)
                    .padding(.horizontal, 35)
                    .padding()
                    .background(Color.black)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .padding(.top)
                }
            }
            .padding(.top, 70)
        }
    }
}

#Preview {
    PreviewView()
}

