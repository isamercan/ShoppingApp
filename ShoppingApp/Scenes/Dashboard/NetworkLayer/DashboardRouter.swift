//
//  DashboardRouter.swift
//  ShoppingApp
//
//  Created by isa on 27.02.2023.
//

import Foundation

enum Method: String {
    case products = "6bb59bbc-e757-4e71-9267-2fee84658ff2"
}

struct DashboardRouter {
    static var allProductsURL: URL {
        do {
            return try productsAPIURL(method: .products)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    // MARK: - General Methods
    private static func productsAPIURL(method: Method) throws -> URL {
        guard let baseURL = URL(string: NetworkConstants.baseUrl),
              let finalURL = URL(string: method.rawValue, relativeTo: baseURL) else {
            throw ShoppingError.undefinedUrl
        }
        return finalURL
    }
}
