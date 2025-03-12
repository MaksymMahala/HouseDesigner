//
//  NetworkingClient.swift
//  HouseDesigner
//
//  Created by Max on 01.03.2025.
//

import Alamofire

class NetworkingClient {
    static let shared = NetworkingClient()
    
    private init() {}
    
    func get<T: Decodable>(url: String, responseType: T.Type, completion: @escaping (Result<T, FurnitureServiceError>) -> Void) {
        AF.request(url, method: .get)
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(.networkError(error)))
                }
            }
    }
}
