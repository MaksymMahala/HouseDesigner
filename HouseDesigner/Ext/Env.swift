//
//  Env.swift
//  HouseDesigner
//
//  Created by Max on 28.02.2025.
//

import SwiftUI

// Create a custom environment key to store screen size
struct ScreenSizeKey: EnvironmentKey {
    static let defaultValue: CGSize = UIScreen.main.bounds.size
}

extension EnvironmentValues {
    var screenSize: CGSize {
        get { self[ScreenSizeKey.self] }
        set { self[ScreenSizeKey.self] = newValue }
    }
}

