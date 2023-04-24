//
//  ProductInfoCellViewModel.swift
//  ShoppingApp
//
//  Created by isa on 1.03.2023.
//

import Foundation

struct ProductCellViewModel: ProductCellViewModelProtocol {
    var productModel: ProductModel
    var productPrice: String
    var productName: String
    var productDescription: String
    var productImage: String
    
    init(product: ProductModel) {
        productModel = product
        productPrice = CurrencyManager.shared.createCurrencyString(amount: product.productPrice)
        productName = product.productName
        productDescription = product.productDescription
        productImage = product.productImage.urlFixer
    }
}
