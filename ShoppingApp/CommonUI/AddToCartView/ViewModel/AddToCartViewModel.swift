//
//  AddToCartViewModel.swift
//  ShoppingApp
//
//  Created by isa on 27.02.2023.
//

import Foundation

final class AddToCartViewModel: AddToCartViewModelProtocol {
    var product:ProductModel? {
        didSet {
            updateStatus(product: product)
        }        
    }
    var isInBasket: Bool = false
    var updateCartItemClosure: ((Bool) -> Void)?
    init(product: ProductModel?) {
        self.product = product
        updateStatus(product: product)
    }
    
    func updateStatus(product: ProductModel?) {
        isInBasket = product?.qty ?? 0 > 0 ? true : false
    }
}
