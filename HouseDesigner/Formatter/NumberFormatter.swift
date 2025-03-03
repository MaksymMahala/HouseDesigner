//
//  NumberFormatter.swift
//  HouseDesigner
//
//  Created by Max on 03.03.2025.
//

import Foundation

class CurrencyFormatter {
    
    static let shared = CurrencyFormatter()
    
    private let formatter: NumberFormatter
    
    private init() {
        self.formatter = NumberFormatter()
        self.formatter.numberStyle = .currency
        self.formatter.currencySymbol = "$"
        self.formatter.minimumFractionDigits = 2
        self.formatter.maximumFractionDigits = 2
    }
    
    func format(price: Double) -> String {
        return formatter.string(from: NSNumber(value: price)) ?? "$0.00"
    }
}
