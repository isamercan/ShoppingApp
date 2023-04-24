//
//  ProductDetailInfoCellViewModelProtocol.swift
//  ShoppingApp
//
//  Created by isa on 2.03.2023.
//

import Foundation

protocol ProductDetailInfoCellViewModelProtocol: BaseCellProtocol {
    var productPrice: String { get }
    var productName: String { get }
    var productDescription: String { get }
}
