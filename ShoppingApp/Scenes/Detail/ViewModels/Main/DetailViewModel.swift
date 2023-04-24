//
//  DetailViewModel.swift
//  ShoppingApp
//
//  Created by isa on 27.02.2023.
//

import UIKit

enum DetailViewModelCellType {
    case image(viewModel: ProductDetailImageCellViewModelProtocol)
    case product(item: ProductDetailInfoCellViewModelProtocol)
    case notAvaliable
}

final class DetailViewModel: DetailViewModelProtocol {
    var feed: [DetailViewModelCellType] = []
    var title: String
    var product: ProductModel
    var updatedProductClosure: (() -> Void)?
    var reloadDataClosure: (() -> Void)?
    
    init(title: String = String(), product: ProductModel) {
        self.product = product
        self.title = title
        self.setupProduct()
    }
    
    func setupProduct() {
        let basketProduct = BasketManager.shared.getSelectedBasketProduct(item: product)
        if basketProduct != nil {
            product = basketProduct!
        } else {
            product.qty = 0
        }
        setupFeed()
    }
    
    func setupFeed() {
        feed = []
        let imageViewModel = ProductDetailImageCellViewModel(product: product)
        feed.append(.image(viewModel: imageViewModel))
        if product.productPrice > 0 || !product.productName.isEmpty {
            let cellViewmodel = ProductDetailInfoCellViewModel(product: product)
            feed.append(.product(item: cellViewmodel))
        } else {
            feed.append(.notAvaliable)
        }
        reloadDataClosure?()
        updatedProductClosure?()
    }
    
    func tableRowCount() -> Int {
        return feed.count
    }
    
    func tableRowHeight(_ indexPath: IndexPath) -> CGFloat {
        let feed = feed[indexPath.section]
        switch feed {
        case .image, .product, .notAvaliable:
            return UITableView.automaticDimension
        }
    }
    
    func updateCartItem(action: Bool) {
        if product.qty == nil {
            product.qty = 0
        }
        
        if action {
            product.qty! += 1
            BasketManager.shared.addItem(product)
        } else if !action, product.qty ?? 0 > 0 {
            product.qty! -= 1
            if product.qty ?? 0 == 0 {
                BasketManager.shared.removeItem(product)
            } else {
                BasketManager.shared.addItem(product)
            }
        }
        setupFeed()
        updatedProductClosure?()
    }
}
