//
//  LoginRouterView.swift
//  HouseDesigner
//
//  Created by Max on 12.03.2025.
//

import SwiftUI

struct RouterView: View {
    var route: LoginRoute

    var body: some View {
        switch route {
        case .register:
            RegisterView()
        }
    }
}
