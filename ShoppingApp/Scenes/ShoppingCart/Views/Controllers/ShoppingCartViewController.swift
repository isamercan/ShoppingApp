//
//  ShoppingCartViewController.swift
//  ShoppingApp
//
//  Created by isa on 28.02.2023.
//

import UIKit

final class ShoppingCartViewController: UIViewController {
    var viewModel: ShoppingCartViewModelProtocol
    private var navigator: ShoppingCartNavigator!
    @IBOutlet private weak var headerView: HeaderView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet weak var btnCheckout: UIButton!
    
    init(viewModel: ShoppingCartViewModelProtocol) {
      self.viewModel = viewModel
      super.init(nibName: "ShoppingCartViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigator = ShoppingCartNavigator(navigationController: navigationController!)
        initVM()
        initUI()
    }
    
    func initUI() {
        tableView.register(CartItemCell.self)
        tableView.register(EmptyCell.self)
    }
    
    func initVM() {
        let headerViewModel = HeaderViewViewModel(title: "Shopping Cart", leftButtonType: .close)
        headerViewModel.didTapDismiss = didTapDismiss
        headerView.btnCart.isUserInteractionEnabled = false
        headerView.setViewData(viewModel: headerViewModel)
        
        viewModel.reloadDataClosure = reloadData()
        viewModel.onErrorHandling = showAlert()
        viewModel.setupFeed()
        btnCheckout.isHidden = !viewModel.isCheckoutable
                
    }
    
    func reloadData() -> (() -> Void)? {
        return { [weak self] () in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.btnCheckout.isHidden = !self.viewModel.isCheckoutable
                self.tableView.reloadData()
            }
        }
    }
    
    func showAlert(err: String) {
        DispatchQueue.main.async {
            AlertManager(navigator: self.navigator).showUIAlert(message: err)
        }
    }
    func showAlert() -> ((String) -> Void)? {
        return { [weak self] error in
            guard let self = self else { return }
            DispatchQueue.main.async {
                AlertManager(navigator: self.navigator).showUIAlert(message: error)
            }
        }
    }
    
    func didTapDismiss() {
        navigator.dismiss()
    }
    
    @IBAction func didTapCheckoutAction(_ sender: UIButton) {
        viewModel.checkOutItems()
        AlertManager(navigator: self.navigator).showUIAlert( title: TextConstants.success,
                                                             message: TextConstants.successCheckout) { [unowned self] result in
            navigator.showDashboard()
        }
    }
}


//MARK: TableView Delegates
extension ShoppingCartViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.tableSectionCount()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tableRowCount(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let feed = viewModel.feed[indexPath.section]
        switch feed {
        case .empty:
            let cell: EmptyCell = tableView.dequeue(cellForRowAt: indexPath)
            return cell
        case .products(let items):
            let cell: CartItemCell = tableView.dequeue(cellForRowAt: indexPath)            
            cell.setCellData(viewModel: items[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.tableRowHeight(indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let feed = viewModel.feed[indexPath.section]
        switch feed {
        case .products(let items):
            navigator.showProductDetail(item: items[indexPath.row].productModel)
        default:
            break
        }
    }
}
