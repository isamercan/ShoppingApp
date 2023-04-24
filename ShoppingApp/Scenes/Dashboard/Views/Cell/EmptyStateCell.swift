//
//  EmptyStateCell.swift
//  ShoppingApp
//
//  Created by isa on 27.02.2023.
//

import UIKit

final class EmptyStateCell: UICollectionViewCell {

    @IBOutlet private weak var lblError: UILabel!
    
    func setCellData(viewModel: ErrorCellViewModelProtocol) {
        lblError.text = viewModel.errorDescription
    }

}
