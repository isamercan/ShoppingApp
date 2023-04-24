//
//  StringExtension.swift
//  ShoppingApp
//
//  Created by isa on 1.03.2023.
//

import Foundation
//If we dont add this suffix to the end of url then Images wor't be displayed.
extension String {
    var urlFixer: String {
        return self + NetworkConstants.urlFixer
    }
}
