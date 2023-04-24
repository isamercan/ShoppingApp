//
//  ErrorCellViewModelProtocol.swift
//  ShoppingApp
//
//  Created by isa on 1.03.2023.
//

import Foundation

protocol ErrorCellViewModelProtocol: BaseCellProtocol {
    var errorTitle: String { get }
    var errorDescription: String { get }
}
