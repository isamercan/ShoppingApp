//
//  DashboardViewModel.swift
//  ShoppingApp
//
//  Created by isa on 26.02.2023.
//

import UIKit

enum DashboardCellType {
    case empty(error: ErrorCellViewModelProtocol)
    case products(viewModels: [ProductCellViewModelProtocol])
    
    var title : String {
        switch self {
        case .empty:
            return TextConstants.empty
        case .products:
            return TextConstants.products
        }
    }
}

final class DashboardViewModel: DashboardViewModelProtocol {
    var feed: [DashboardCellType] = []
    var cellSize: CGSize = .zero
    var emptyCellSize: CGSize = .zero
    var reloadDataClosure: (() -> Void)?
    var onErrorHandling : ((String) -> Void)?
    var products: [ProductModel] = []
    let networkService = NetworkService()
    
    init() {
        calculateSizes()
    }
    
    func initializeData() {
        networkService.request(to: DashboardRouter.allProductsURL, completion: NetworkHandler().networkResult(completion: { [weak self] (result: Result<[ProductModel], Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let items):
                self.products = items
            case .failure(let error):
                print(error)
                self.onErrorHandling?(error.localizedDescription)
            }
            self.setupFeed()
        }))?.resume()
    }
    
    func initializeProductViewModels(products: [ProductModel]) -> [ProductCellViewModelProtocol] {
        return products.map({ (product: ProductModel) -> ProductCellViewModelProtocol in
            return ProductCellViewModel(product: product)
        })
    }
    
    func calculateSizes() {
        let numberOfColums = 2
        let sumOfIndents = (StyleConstants.Size.medium * 2) + CGFloat((numberOfColums - 1)) * StyleConstants.Size.medium
        let width = (UIScreen.main.bounds.width - sumOfIndents) / 2
        let emptyWidth = (UIScreen.main.bounds.width - sumOfIndents)
        let height = width * 1.6
        cellSize = CGSize(width: width, height: height)
        emptyCellSize = CGSize(width: emptyWidth, height: emptyWidth * 1.6)
    }
    
    func setupFeed() {
        feed = []
        guard products.count > 0 else {
            let errorViewModel = ErrorCellViewModel(error: ShoppingError.empty)
            feed.append(.empty(error: errorViewModel))
            reloadDataClosure?()
            return
        }        
        feed.append(.products(viewModels: initializeProductViewModels(products: products)))
        reloadDataClosure?()
    }
    
    func collectionSectionCount() -> Int {
        return feed.count
    }
    
    func collectionRowCount(_ section: Int) -> Int {
        let feed = feed[section]
        switch feed {
        case .empty:
            return 1
        case .products(let items):
            return items.count
        }
    }
    
    func collectionCellSize(_ section: Int) -> CGSize {
        let feed = feed[section]
        switch feed {
        case .empty:
            return emptyCellSize
        case .products:
            return cellSize
        }
    }
}
