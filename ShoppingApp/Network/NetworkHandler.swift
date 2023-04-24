//
//  NetworkHandler.swift
//  ShoppingApp
//
//  Created by isa on 27.02.2023.
//

import Foundation

final class NetworkHandler {
    func networkResult<T: Codable>(completion: @escaping ((Result<T, Error>) -> Void)) -> ((Result<Data, Error>) -> Void) {
        return { dataResult in
            DispatchQueue.global(qos: .background).async(execute: {
                switch dataResult {
                case .success(let data) :
                    do {
                        let result = try JsonParser().convertToModel(data: data, decodingType: T.self)
                        completion(.success(result!))
                    } catch(let err) {
                        completion(.failure(err))
                    }
                case .failure(let error) :
                    print("Network error \(error)")
                    completion(.failure(error))
                }
            })
        }
    }
}
