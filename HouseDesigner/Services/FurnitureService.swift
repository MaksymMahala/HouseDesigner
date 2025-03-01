//
//  FurnitureService.swift
//  HouseDesigner
//
//  Created by Max on 01.03.2025.
//

import Alamofire

class FurnitureService: FurnitureServiceProtocol {
    static let shared = FurnitureService()
    
    private let networkingClient: NetworkingClient
    
    // Inject dependency (DIP: Dependency Injection)
    init(networkingClient: NetworkingClient = .shared) {
        self.networkingClient = networkingClient
    }
    
    func fetchFurnitureData(completion: @escaping (Result<[FurnitureCellData], FurnitureServiceError>) -> Void) {
        networkingClient.get(url: Constants.URLs.furnitureURL, responseType: [FurnitureCellData].self) { result in
            switch result {
            case .success(let furnitureItems):
                completion(.success(furnitureItems))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
