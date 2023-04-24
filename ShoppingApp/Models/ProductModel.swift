//
//  ProductModel.swift
//  ShoppingApp
//
//  Created by isa on 26.02.2023.
//

import Foundation

// MARK: - ProductModel
struct ProductModel: Codable {
    let productName: String
    let productDescription: String
    let productPrice: Double
    let productImage: String
    var qty: Int?
}
