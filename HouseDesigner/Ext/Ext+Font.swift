//
//  Ext+Font.swift
//  HouseDesigner
//
//  Created by Max on 28.02.2025.
//

import SwiftUI

extension Font {
    // Default Font Style
    static let bodyFont: Font = .system(size: 16, weight: .regular, design: .default)
    
    // Title Font Style
    static let titleFont: Font = .system(size: 24, weight: .bold, design: .default)
    
    // Large Title Font Style
    static let largeTitleFont: Font = .system(size: 32, weight: .heavy, design: .default)
    
    // Caption Font Style
    static let captionFont: Font = .system(size: 12, weight: .light, design: .default)
    
    static let nunitoSans_7pt_CondensedBold20: Font = .custom("NunitoSans_7pt_Condensed-Bold", size: 20)
    static let nunitoSans_7pt_CondensedBold22: Font = .custom("NunitoSans_7pt_Condensed-Bold", size: 22)
    static let nunitoSans_7pt_CondensedMedium22: Font = .custom("NunitoSans_7pt_Condensed-Medium", size: 22)

    static let plusJakartaSansBold15: Font = .custom("PlusJakartaSans-Bold", size: 15)
    static let plusJakartaSansBold17: Font = .custom("PlusJakartaSans-Bold", size: 17)
    static let plusJakartaSansBold22: Font = .custom("PlusJakartaSans-Bold", size: 22)
    static let plusJakartaSansBold32: Font = .custom("PlusJakartaSans-Bold", size: 32)

    static let plusJakartaSansRagular15: Font = .custom("PlusJakartaSans-Regular", size: 15)
    static let plusJakartaSansRagular17: Font = .custom("PlusJakartaSans-Regular", size: 17)
    static let plusJakartaSansRagular22: Font = .custom("PlusJakartaSans-Regular", size: 22)
    static let plusJakartaSansRagular32: Font = .custom("PlusJakartaSans-Regular", size: 32)

    static func dynamicFontPlusJakartaSansBold(for size: CGSize) -> Font {
        return size.width > 375 ? Font.plusJakartaSansBold32 : Font.plusJakartaSansBold22
    }
    
    static func dynamicFontPlusJakartaSansRagular(for size: CGSize) -> Font {
        return size.width > 375 ? Font.plusJakartaSansRagular32 : Font.plusJakartaSansRagular22
    }
}
