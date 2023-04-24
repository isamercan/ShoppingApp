//
//  CartItemCellViewModel.swift
//  ShoppingApp
//
//  Created by isa on 2.03.2023.
//

import Foundation

struct CartItemCellViewModel: CartItemCellViewModelProtocol {
    var productModel: ProductModel
    var productPrice: String
    var productName: String
    var productImage: String
    var productQty: String
    
    init(product: ProductModel) {
        productModel = product
        productPrice = CurrencyManager.shared.createCurrencyString(amount: product.productPrice)
        productName = product.productName
        productImage = product.productImage.urlFixer
        productQty = (product.qty?.toString() ?? String()) + String(" ") + TextConstants.qty
    }
}
