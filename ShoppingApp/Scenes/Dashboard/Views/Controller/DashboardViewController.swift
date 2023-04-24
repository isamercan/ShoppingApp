//
//  DashboardVC.swift
//  ShoppingApp
//
//  Created by isa on 26.02.2023.
//

import UIKit

final class DashboardViewController: UIViewController {
    var viewModel: DashboardViewModelProtocol
    private var navigator: DashboardNavigator!
    @IBOutlet private weak var headerView: HeaderView!
    @IBOutlet private weak var collectionView: UICollectionView!
    var collectionViewLayout =  UICollectionViewFlowLayout()
    
    init(viewModel: DashboardViewModelProtocol) {
      self.viewModel = viewModel
      super.init(nibName: "DashboardViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigator = DashboardNavigator(navigationController: navigationController!)
        initUI()
        initVM()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        headerView.initManager()
    }
            
    func initUI() {
        setCollectionView()
    }
    
    func initVM() {
        let headerViewModel = HeaderViewViewModel(title: TextConstants.shoppingApp, leftButtonType: .none)
        headerViewModel.didTapDismiss = didTapDismiss
        headerViewModel.didTapCart = didTapCart
        headerView.setViewData(viewModel: headerViewModel)
        
        viewModel.reloadDataClosure = reloadData()
        viewModel.onErrorHandling = showAlert
        viewModel.initializeData()
    }
    
    func reloadData() -> (() -> Void)? {
        return { [weak self] () in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
    
    func showAlert(err: String) {
        DispatchQueue.main.async {
            AlertManager(navigator: self.navigator).showUIAlert(message: err)
        }
    }
    
    func didTapDismiss() {
        navigator.dismiss()
    }
    
    func didTapCart() {
        navigator.showCart()
    }
}

extension DashboardViewController {
    private func setCollectionView() {        
        collectionView.setCollectionViewLayout(collectionViewLayout, animated: true)
        collectionView.register(ProductListItemCell.self)
        collectionView.register(EmptyStateCell.self)
        collectionViewLayout.minimumLineSpacing = 0
    }
}

extension DashboardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.collectionSectionCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.collectionRowCount(section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let feed = viewModel.feed[indexPath.section]
        switch feed {
        case .empty(let error):
            let cell: EmptyStateCell = collectionView.dequeue(cellForRowAt: indexPath)
            cell.setCellData(viewModel: error)
            return cell
        case .products(let items):
            let cell: ProductListItemCell = collectionView.dequeue(cellForRowAt: indexPath)
            cell.setCellData(viewModel: items[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let feed = viewModel.feed[indexPath.section]
        switch feed {
        case .empty:
            guard let navigator = self.navigator else { return }
            AlertManager(navigator: navigator).showUIAlert(message: ShoppingError.empty.errorReason)
        case .products(let items):
            navigator.showProductDetail(item: items[indexPath.row].productModel)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.collectionCellSize(indexPath.section)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: StyleConstants.Size.medium, bottom: 0, right: StyleConstants.Size.medium)
    }
}
