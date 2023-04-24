//
//  ProductInfoCell.swift
//  ShoppingApp
//
//  Created by isa on 27.02.2023.
//

import UIKit


final class ProductInfoCell: UITableViewCell {

    @IBOutlet private weak var lblPrice: UILabel!
    @IBOutlet private weak var lblProductName: UILabel!
    @IBOutlet private weak var lblProductDescription: UILabel!
    
    func setCellData(viewModel: ProductDetailInfoCellViewModelProtocol) {
        lblPrice.text = viewModel.productPrice
        lblProductName.text = viewModel.productName
        lblProductDescription.text = viewModel.productDescription
    }
}
