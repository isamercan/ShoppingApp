//
//  HeaderViewViewModel.swift
//  ShoppingApp
//
//  Created by isa on 26.02.2023.
//

import Foundation

final class HeaderViewViewModel: HeaderViewModelProtocol {
    var title: String
    var leftButtonType: HeaderViewLeftButtonType
    var didTapCart: (() -> Void)?
    var didTapDismiss: (() -> Void)?
    
    init(title: String = String(), leftButtonType: HeaderViewLeftButtonType = .none) {
        self.leftButtonType = leftButtonType
        self.title = title
    }
}
