//
//  ShoppingCartViewModel.swift
//  ShoppingApp
//
//  Created by isa on 28.02.2023.
//

import UIKit

enum ShoppingCartCellType {
    case empty(error: String)
    case products(viewModel: [CartItemCellViewModelProtocol])
}


final class ShoppingCartViewModel: ShoppingCartViewModelProtocol {
    var products: [ProductModel] = []
    var reloadDataClosure: (() -> Void)?
    var onErrorHandling: ((String) -> Void)?
    var feed: [ShoppingCartCellType] = []
    var isCheckoutable: Bool = false
    
    func setupFeed() {
        feed = []
        products = BasketManager.shared.getBasketItems()
        guard products.count > 0 else {
            feed.append(.empty(error: ShoppingError.empty.errorReason))
            onErrorHandling?(ShoppingError.emptyBasket.errorReason)
            isCheckoutable = false
            reloadDataClosure?()
            return
        }
        isCheckoutable = true
        feed.append(.products(viewModel: initializeProductViewModels(products: products)))
        reloadDataClosure?()
    }
    
    func initializeProductViewModels(products: [ProductModel]) -> [CartItemCellViewModelProtocol] {
        return products.map({ (product: ProductModel) -> CartItemCellViewModelProtocol in
            return CartItemCellViewModel(product: product)
        })
    }
    
    func checkOutItems() {
        guard BasketManager.shared.checkoutItems() else { return }
        setupFeed()
    }
    
    func tableSectionCount() -> Int {
        return feed.count
    }
    
    func tableRowCount(_ section: Int) -> Int {
        let feed = feed[section]
        switch feed {
        case .empty:
            return 1
        case .products(viewModel: let items):
            return items.count
        
        }
    }
    
    func tableRowHeight(_ indexPath: IndexPath) -> CGFloat {
        let feed = feed[indexPath.section]
        switch feed {
        case .empty:
            return UITableView.automaticDimension
        case .products:
            return 125
        }
    }
}
