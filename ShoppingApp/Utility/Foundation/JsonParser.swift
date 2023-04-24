//
//  JsonParser.swift
//  ShoppingApp
//
//  Created by isa on 27.02.2023.
//

import Foundation

final class JsonParser {
    func convertToModel<T: Codable>(data: Data, decodingType: T.Type) throws -> T? {
        return try JSONDecoder().decode(T.self, from: data)
    }
}
