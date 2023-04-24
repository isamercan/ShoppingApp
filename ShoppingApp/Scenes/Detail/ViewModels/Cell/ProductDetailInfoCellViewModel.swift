//
//  ProductDetailInfoCellViewModel.swift
//  ShoppingApp
//
//  Created by isa on 2.03.2023.
//

import Foundation
struct ProductDetailInfoCellViewModel: ProductDetailInfoCellViewModelProtocol {
    var productPrice: String
    var productName: String
    var productDescription: String

    init(product: ProductModel) {
        productPrice = CurrencyManager.shared.createCurrencyString(amount: product.productPrice)
        productName = product.productName
        productDescription = product.productDescription
    }
}
