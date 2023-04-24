//
//  ProductInfoCellViewModelProtocol.swift
//  ShoppingApp
//
//  Created by isa on 1.03.2023.
//

import Foundation
protocol ProductCellViewModelProtocol: BaseCellProtocol {
    var productModel: ProductModel { get }
    var productPrice: String { get }
    var productName: String { get }
    var productDescription: String { get }
    var productImage: String { get }
}
