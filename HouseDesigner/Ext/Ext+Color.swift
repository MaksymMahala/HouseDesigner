//
//  Ext+Color.swift
//  HouseDesigner
//
//  Created by Max on 28.02.2025.
//
import SwiftUICore

extension Color {
    init(hex: String) {
        // Remove leading # if present
        let cleanHex = hex.replacingOccurrences(of: "#", with: "")
        
        // Make sure we have a valid hex string
        guard cleanHex.count == 6 else {
            self = Color.black  // Return black if invalid hex
            return
        }
        
        // Get RGB components from the hex string
        let scanner = Scanner(string: cleanHex)
        var hexInt: UInt64 = 0
        scanner.scanHexInt64(&hexInt)
        
        let red = Double((hexInt & 0xFF0000) >> 16) / 255.0
        let green = Double((hexInt & 0x00FF00) >> 8) / 255.0
        let blue = Double(hexInt & 0x0000FF) / 255.0
        
        // Initialize the Color using RGB values
        self = Color(red: red, green: green, blue: blue)
    }
    
    static func privatePriomaryColorWhite(colorScheme: ColorScheme) -> Color {
        return colorScheme == .dark ? Color.white : Color.black
    }
    
    static func privatePriomaryColorBlack(colorScheme: ColorScheme) -> Color {
        return colorScheme == .dark ? Color.black : Color.white
    }
    
    static let lightGray: Color = Color.gray.opacity(0.6)
    static let lightWhite: Color = Color.white.opacity(0.4)
}
