//
//  ShoppingCartViewModelProtocol.swift
//  ShoppingApp
//
//  Created by isa on 28.02.2023.
//

import Foundation
protocol ShoppingCartViewModelProtocol {
    var isCheckoutable: Bool { get }
    var feed: [ShoppingCartCellType] { get }
    var reloadDataClosure: (() -> Void)? { get set}
    var onErrorHandling : ((String) -> Void)? { get set}
    func setupFeed()
    func checkOutItems()
    func tableSectionCount() -> Int
    func tableRowCount(_ section: Int) -> Int
    func tableRowHeight(_ indexPath: IndexPath) -> CGFloat
}
