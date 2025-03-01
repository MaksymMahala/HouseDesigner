//
//  Ext+Size.swift
//  HouseDesigner
//
//  Created by Max on 28.02.2025.
//

import SwiftUI

// Define a custom view modifier that injects the screen size into a view
struct ScreenSizeModifier: ViewModifier {
    var screenSize: CGSize
    
    func body(content: Content) -> some View {
        content
            .environment(\.screenSize, screenSize)
    }
}
