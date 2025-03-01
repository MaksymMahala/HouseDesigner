//
//  Ext+View.swift
//  HouseDesigner
//
//  Created by Max on 28.02.2025.
//

import SwiftUI

extension View {
    func withScreenSize() -> some View {
        modifier(ScreenSizeModifier(screenSize: UIScreen.main.bounds.size))
    }
}
