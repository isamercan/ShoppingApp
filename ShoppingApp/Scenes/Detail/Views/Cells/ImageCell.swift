//
//  ImageTVC.swift
//  ShoppingApp
//
//  Created by isa on 27.02.2023.
//

import UIKit

final class ImageCell: UITableViewCell {
    @IBOutlet private weak var productImageView: UIImageView!
    
    func setCellData(viewModel: ProductDetailImageCellViewModelProtocol) {
        productImageView.loadImage(viewModel.productImage)
    }
}
