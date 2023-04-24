//
//  AddToCartViewModelProtocol.swift
//  ShoppingApp
//
//  Created by isa on 27.02.2023.
//

import Foundation

protocol AddToCartViewModelProtocol: AnyObject {
    var product: ProductModel? { get set }
    var isInBasket: Bool { get set }
    var updateCartItemClosure: ((Bool) -> Void)? { get set }
}
