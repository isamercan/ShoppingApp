//
//  DefaultsExtension.swift
//  ShoppingApp
//
//  Created by isa on 26.02.2023.
//

import Foundation
enum DefaultsKeys: String {
    case removedItem = "removedItem"
    case addedItem = "addedItem"
    case basketItems = "basketItems"
}

final class Defaults: UserDefaults {
    class func get<T>(_ key: DefaultsKeys) -> T? {
        return UserDefaults.standard.value(forKey: key.rawValue) as? T
    }
    class func set<T>(_ key: DefaultsKeys, value: T) {
        UserDefaults.standard.setValue(value, forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }
    class func remove(_ key: DefaultsKeys) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }
}
