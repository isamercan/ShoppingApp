//
//  NsNumberExtension.swift
//  ShoppingApp
//
//  Created by isa on 27.02.2023.
//

import Foundation

extension NSNumber {
    func isInteger() -> Bool {
        return self.doubleValue.truncatingRemainder(dividingBy: 1) == 0
    }
}
