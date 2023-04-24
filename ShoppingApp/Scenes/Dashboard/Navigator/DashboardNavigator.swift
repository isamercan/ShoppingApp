//
//  DashboardNavigator.swift
//  ShoppingApp
//
//  Created by isa on 26.02.2023.
//

import Foundation

final class DashboardNavigator: BaseNavigator {
    
  func showProductDetail(item: ProductModel) {
        let vm = DetailViewModel(title: TextConstants.productDetail, product: item)
        let productDetailVC = DetailViewController(viewModel: vm)
        present(vc: productDetailVC)
    }
}
