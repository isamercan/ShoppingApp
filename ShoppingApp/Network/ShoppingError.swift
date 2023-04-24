//
//  ShoppingError.swift
//  ShoppingApp
//
//  Created by isa on 28.02.2023.
//

import Foundation
enum ShoppingError: Error {
    case common
    case undefinedUrl
    case notParsed
    case empty
    case emptyBasket
    case invalidProduct(ProductModel)
}

extension ShoppingError {
    var errorTitle: String {
        switch self {
        case .common:
            return TextConstants.errorCommunTitle
        case .undefinedUrl:
            return TextConstants.errorInvalidRequestTitle
        case .notParsed:
            return TextConstants.errorParsingTitle
        case .empty:
            return TextConstants.errorCommunTitle
        case .emptyBasket:
            return TextConstants.empty
        case .invalidProduct(let productModel):
            return TextConstants.errorFailed
        }
    }
}

extension ShoppingError {
    var errorReason: String {
        switch self {
        case .common:
            return NSLocalizedString(
                "An error occured",
                comment: String()
            )
        case .notParsed:
            return NSLocalizedString(
                "JSON.parse: unexpected error occured",
                comment: String()
            )
        case .empty:
            return NSLocalizedString(
                "Sorry, the products you were looking for were not found.",
                comment: String()
            )
        case .emptyBasket:
            return NSLocalizedString(
                "You have 0 items in your basket.",
                comment: String()
            )
        case .undefinedUrl:
            return NSLocalizedString(
                "Url is not exist",
                comment: String()
            )
        case .invalidProduct(let product):
            let format = NSLocalizedString(
                "Expected output: We could not find '%@'",
                comment: String()
            )
            return String(format: format, String(product.productName))
        }
    }
}
