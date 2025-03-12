//
//  CartView.swift
//  HouseDesigner
//
//  Created by Max on 03.03.2025.
//

import SwiftUI

class CartViewModel: ObservableObject {
    
}

struct CartView: View {
    @StateObject private var viewModel = CartViewModel()
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    CartView()
}
