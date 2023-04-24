//
//  BasketManager.swift
//  ShoppingApp
//
//  Created by isa on 26.02.2023.
//

import Foundation

protocol BasketManagerProtocol {
    func getBasketItems() -> [ProductModel]
    func addItem(_ item: ProductModel)
    func removeItem(_ item: ProductModel)
    func getTotalAmount() -> Double
}

final class BasketManager: BasketManagerProtocol {
    private init() {}
    static let shared = BasketManager()
    var updateBasketStatus: (() -> Void)?
    
    var totalAmount: ((Double)-> Void)? {
        didSet {
            totalAmount?(getTotalAmount())
        }
    }
    
    func getBasketItems() -> [ProductModel] {
        if let savedItems: Data = Defaults.get(.basketItems) {
            do{
                let items = try JSONDecoder().decode([ProductModel].self, from: savedItems)
                return items
            } catch {
                // Failed to convert Data to Products
            }
        }
        return []
    }
    
    func addItem(_ item: ProductModel) {
        var items = getBasketItems()
        //Remove exist item
        items = items.filter { $0.productName != item.productName }
        // Add Item updated qty
        items.append(item)
        do {
            let encodedItemsData = try JSONEncoder().encode(items)
            let encodedItem = try JSONEncoder().encode(item)
            Defaults.set(.addedItem, value: encodedItem)
            Defaults.set(.basketItems, value: encodedItemsData)
        } catch {
            // Failed to encode ProductModel to Data
        }
        totalAmount?(getTotalAmount())
        updateBasketStatus?()
    }
    
    func removeItem(_ item: ProductModel) {
        var items = getBasketItems()
        //Remove exist item
        items = items.filter { $0.productName != item.productName }
        do{
            let encodedItems = try JSONEncoder().encode(items)
            let encodedItem = try JSONEncoder().encode(item)
            Defaults.set(.addedItem, value: encodedItem)
            Defaults.set(.basketItems, value: encodedItems)
        } catch {
            //Failed
        }
        totalAmount?(getTotalAmount())
        updateBasketStatus?()
    }
    
    func getTotalAmount() -> Double {
        var amount: Double = 0
        if let savedItems: Data = Defaults.get(.basketItems) {
            do{
                let items = try JSONDecoder().decode([ProductModel].self, from: savedItems)
                for item in items {
                    amount += item.productPrice * Double(item.qty ?? 1)
                }
            } catch {
                // Failed to convert Data to Product
            }
        }
        return amount
    }
    
    func removeAllItems() {
        let items: [ProductModel] = []
        do {
            let encodedItemsData = try JSONEncoder().encode(items)
            Defaults.set(.basketItems, value: encodedItemsData)
        } catch {
            // Failed to encode ProductModel to Data
        }
        totalAmount?(getTotalAmount())
        updateBasketStatus?()
    }
    
    func getSelectedBasketProduct(item: ProductModel) -> ProductModel? {
        return getBasketItems().filter { $0.productName == item.productName }.first
    }
    
    func isInList(item: ProductModel) -> Bool {
        guard !getBasketItems().filter({ $0.productName == item.productName }).isEmpty else { return false}
        return true
    }
    
    func checkoutItems() -> Bool {
        totalAmount?(getTotalAmount())
        removeAllItems()
        return getBasketItems().count == 0 ? true : false
    }
}

