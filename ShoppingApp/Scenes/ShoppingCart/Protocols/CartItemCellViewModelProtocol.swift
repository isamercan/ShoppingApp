//
//  CartItemCellViewModelProtocol.swift
//  ShoppingApp
//
//  Created by isa on 2.03.2023.
//

import Foundation
protocol CartItemCellViewModelProtocol: BaseCellProtocol {
    var productModel: ProductModel { get }
    var productPrice: String { get }
    var productName: String { get }
    var productImage: String { get }
    var productQty: String { get }
}
