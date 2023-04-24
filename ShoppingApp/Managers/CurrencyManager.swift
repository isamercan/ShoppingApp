//
//  CurrencyManager.swift
//  ShoppingApp
//
//  Created by isa on 27.02.2023.
//

import Foundation

final class CurrencyManager {
    static let shared = CurrencyManager()
    
    func createCurrencyString(amount: Double) -> String {
        let amountString = NumberFormatter.currencyFormatter().string(from: NSNumber(value: amount)) ?? String()
                            
        if Locale.current.languageCode == "tr" {
            return "₺" + amountString
        } else {
            return "$" + amountString
        }
    }
}
