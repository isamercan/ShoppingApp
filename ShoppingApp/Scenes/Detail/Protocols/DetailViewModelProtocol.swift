//
//  DetailViewModelProtocol.swift
//  ShoppingApp
//
//  Created by isa on 27.02.2023.
//

import Foundation
protocol DetailViewModelProtocol {
    var feed: [DetailViewModelCellType] { get }
    var title: String { get }
    var product: ProductModel { get }
    var reloadDataClosure: (() -> Void)? { get set }
    var updatedProductClosure: (() -> Void)? { get set }
    func updateCartItem(action: Bool)
    func tableRowCount() -> Int
    func tableRowHeight(_ indexPath: IndexPath) -> CGFloat
}
