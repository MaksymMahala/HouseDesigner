//
//  NavigationEnv.swift
//  HouseDesigner
//
//  Created by Max on 11.03.2025.
//

import SwiftUI

class NavigationEnv: ObservableObject {
    @Published var isLogin = false
}

struct MainView: View {
    @ObservedObject private var navigationEnv = NavigationEnv()
    var body: some View {
        if navigationEnv.isLogin {
            CustomTabBarView()
        } else {
            LoginView()
                .environmentObject(navigationEnv)
        }
    }
}

#Preview {
    MainView()
}
