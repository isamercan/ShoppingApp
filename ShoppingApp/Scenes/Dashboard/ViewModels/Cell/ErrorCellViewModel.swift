//
//  ErrorCellViewModel.swift
//  ShoppingApp
//
//  Created by isa on 2.03.2023.
//

import Foundation

struct ErrorCellViewModel: ErrorCellViewModelProtocol {
    var errorTitle: String
    var errorDescription: String
    
    init(error: ShoppingError) {
        errorTitle = error.errorTitle
        errorDescription = error.errorReason
    }
}
