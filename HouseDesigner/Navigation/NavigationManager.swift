//
//  LoginRouter.swift
//  HouseDesigner
//
//  Created by Max on 12.03.2025.
//

import Foundation
import SwiftUI

enum LoginRoute: Hashable {
    case register
}

protocol NavigationProtocol {
    func navigate(to route: LoginRoute)
    func goBack()
    func resetToHome()
}

class NavigationLoginManager: ObservableObject, NavigationProtocol {
    @Published var path: [LoginRoute] = []

    func navigate(to route: LoginRoute) {
        path.append(route)
    }

    func goBack() {
        if !path.isEmpty {
            path.removeLast()
        }
    }

    func resetToHome() {
        path.removeAll()
    }
}
