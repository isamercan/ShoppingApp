//
//  ProductListItemCVC.swift
//  ShoppingApp
//
//  Created by isa on 26.02.2023.
//

import UIKit

final class ProductListItemCell: UICollectionViewCell {

    @IBOutlet private weak var lblName: UILabel!
    @IBOutlet private weak var lblPrice: UILabel!
    @IBOutlet private weak var productImageView: UIImageView!
    
    func setCellData(viewModel: ProductCellViewModelProtocol) {
        lblPrice.text = viewModel.productPrice
        lblName.text = viewModel.productName
        productImageView.loadImage(viewModel.productImage)
    }
}
