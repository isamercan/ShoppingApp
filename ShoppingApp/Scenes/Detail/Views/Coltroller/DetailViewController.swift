//
//  ProductDetailVC.swift
//  ShoppingApp
//
//  Created by isa on 26.02.2023.
//

import UIKit

final class DetailViewController: UIViewController {
    var viewModel: DetailViewModelProtocol
    private var navigator: DetailNavigator?
    @IBOutlet private weak var headerView: HeaderView!
    @IBOutlet private weak var addToCartView: AddToCartView!
    @IBOutlet private weak var tableView: UITableView!
  
    init(viewModel: DetailViewModelProtocol) {
      self.viewModel = viewModel
      super.init(nibName: "DetailViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        navigator = DetailNavigator(navigationController: navigationController!)
        initVM()
        initUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initVM()
    }
    
    func initUI() {
        tableView.register(ImageCell.self)
        tableView.register(ProductInfoCell.self)
        tableView.register(EmptyCell.self)
    }
    
    func initVM() {
        let headerViewModel = HeaderViewViewModel(title: viewModel.title, leftButtonType: .back)
        headerViewModel.didTapDismiss = didTapDismiss
        headerViewModel.didTapCart = didTapCart
        headerView.setViewData(viewModel: headerViewModel)
        let addToCartViewModel = AddToCartViewModel(product: viewModel.product)
        addToCartView.setViewData(viewModel: addToCartViewModel)
        addToCartView.viewModel.updateCartItemClosure = viewModel.updateCartItem
        viewModel.reloadDataClosure = reloadData()
        viewModel.updatedProductClosure = updatedProductData()
    }
    
    func reloadData() -> (() -> Void)? {
        return { [weak self] () in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func updatedProductData() -> (() -> Void)? {
        return { [weak self] () in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.addToCartView.updateAmount(product: self.viewModel.product)
            }
        }
    }
    
    func didTapDismiss() {
        navigator?.dismiss()
    }
    
    func didTapCart() {
        navigator?.showCart()
    }
}

//MARK: TableView Delegates
extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tableRowCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let feed = viewModel.feed[indexPath.row]
        switch feed {
        case .image(let viewModel):
            let cell: ImageCell = tableView.dequeue(cellForRowAt: indexPath)
            cell.setCellData(viewModel: viewModel)
            return cell
        case .product(let item):
            let cell: ProductInfoCell = tableView.dequeue(cellForRowAt: indexPath)
            cell.setCellData(viewModel: item)
            return cell
        case .notAvaliable:
            let cell: EmptyCell = tableView.dequeue(cellForRowAt: indexPath)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.tableRowHeight(indexPath)
    }
}
