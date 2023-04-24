//
//  IntExtension.swift
//  ShoppingApp
//
//  Created by isa on 26.02.2023.
//

import Foundation
extension Int {
    func toFormattedString() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let formattedAmount = numberFormatter.string(from: NSNumber(value:self)) ?? String()
        return formattedAmount
    }
    
    func toString() -> String {
        return String(self)
    }
}
