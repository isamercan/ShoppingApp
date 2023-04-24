//
//  DashboardProtocol.swift
//  ShoppingApp
//
//  Created by isa on 26.02.2023.
//

import Foundation

protocol DashboardViewModelProtocol {    
    var reloadDataClosure: (() -> Void)? { get set }
    var onErrorHandling : ((String) -> Void)? { get set }
    var feed: [DashboardCellType] { get }
    func initializeData()
    func collectionSectionCount() -> Int
    func collectionRowCount(_ section: Int) -> Int
    func collectionCellSize(_ section: Int) -> CGSize
}
