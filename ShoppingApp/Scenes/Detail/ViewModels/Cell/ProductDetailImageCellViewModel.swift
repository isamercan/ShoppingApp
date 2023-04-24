//
//  ProductDetailImageCellViewModel.swift
//  ShoppingApp
//
//  Created by isa on 2.03.2023.
//

import Foundation

struct ProductDetailImageCellViewModel: ProductDetailImageCellViewModelProtocol {
    var productImage: String
    init(product: ProductModel) {
        productImage = product.productImage.urlFixer
    }
}
