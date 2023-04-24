//
//  ArrayExtension.swift
//  ShoppingApp
//
//  Created by isa on 26.02.2023.
//

import Foundation
extension Array where Element: Equatable {
    mutating func remove(object: Element) {
        guard let index = firstIndex(of: object) else {return}
        remove(at: index)
    }
}
