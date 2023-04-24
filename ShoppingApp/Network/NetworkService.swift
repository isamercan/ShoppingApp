//
//  NetworkService.swift
//  ShoppingApp
//
//  Created by isa on 27.02.2023.
//

import Foundation

protocol NetworkModelProtocol: AnyObject {
    func request(to url: URL, completion: @escaping (Result<Data, Error>) -> Void)  -> URLSessionTask?
}

final class NetworkService: NetworkModelProtocol {
    private let session: URLSession
    
    init(_ session: URLSession = URLSession(configuration: .default)) {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 30.0
        sessionConfig.timeoutIntervalForResource = 60.0
        self.session = URLSession(configuration: sessionConfig)
    }
        
    func request(to url: URL, completion: @escaping (Result<Data, Error>) -> Void) -> URLSessionTask? {
        let request = NetworkMethod.request(method: .GET, url: url)
        let task = session.dataTask(with: request) { (data, _, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            if let data = data {                
                completion(.success(data))
            }
        }
        task.resume()
        return task
    }
}
