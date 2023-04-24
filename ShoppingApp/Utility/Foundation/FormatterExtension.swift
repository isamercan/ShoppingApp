//
//  Formatter.swift
//  ShoppingApp
//
//  Created by isa on 27.02.2023.
//

import Foundation
extension Formatter {
    class func currencyFormatter() -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.alwaysShowsDecimalSeparator = true
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.groupingSeparator = "."
        formatter.decimalSeparator = ","
        return formatter
    }
}
