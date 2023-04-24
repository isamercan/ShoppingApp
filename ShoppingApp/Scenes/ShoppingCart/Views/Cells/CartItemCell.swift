//
//  CartItemCell.swift
//  ShoppingApp
//
//  Created by isa on 28.02.2023.
//

import UIKit

class CartItemCell: UITableViewCell {
    
    @IBOutlet private weak var productImageView: UIImageView!
    @IBOutlet private weak var lblPrice: UILabel!
    @IBOutlet private weak var lblProductName: UILabel!
    @IBOutlet private weak var lblProductQty: UILabel!

    func setCellData(viewModel: CartItemCellViewModelProtocol) {
        lblPrice.text = viewModel.productPrice
        lblProductName.text = viewModel.productName
        lblProductQty.text = viewModel.productQty
        productImageView.loadImage(viewModel.productImage)
    }
}
