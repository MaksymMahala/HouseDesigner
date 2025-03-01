//
//  Ext+Color.swift
//  HouseDesigner
//
//  Created by Max on 28.02.2025.
//
import SwiftUICore

extension Color {
    static func privatePriomaryColorWhite(colorScheme: ColorScheme) -> Color {
        return colorScheme == .dark ? Color.white : Color.black
    }
    
    static func privatePriomaryColorBlack(colorScheme: ColorScheme) -> Color {
        return colorScheme == .dark ? Color.black : Color.white
    }
}
