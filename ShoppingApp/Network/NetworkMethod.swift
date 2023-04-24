//
//  NetworkMethod.swift
//  ShoppingApp
//
//  Created by isa on 27.02.2023.
//

import Foundation

final class NetworkMethod {
    enum Method: String {
        case GET, POST, PUT, DELETE, PATCH
    }

    static func request(method: Method, url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue        
        return request
    }
}
