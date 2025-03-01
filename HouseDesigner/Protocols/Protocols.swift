//
//  Protocols.swift
//  HouseDesigner
//
//  Created by Max on 01.03.2025.
//

import Foundation

protocol FurnitureServiceProtocol {
    func fetchFurnitureData(completion: @escaping (Result<[FurnitureCellData], FurnitureServiceError>) -> Void)
}
