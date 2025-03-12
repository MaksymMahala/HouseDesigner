//
//  FurnitureServiceError.swift
//  HouseDesigner
//
//  Created by Max on 01.03.2025.
//

import Foundation

enum FurnitureServiceError: Error {
    case networkError(Error)
    case decodingError(Error)
    case invalidResponse
    case unknown
}
