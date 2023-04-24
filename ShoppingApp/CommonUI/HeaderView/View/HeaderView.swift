//
//  HeaderView.swift
//  ShoppingApp
//
//  Created by isa on 26.02.2023.
//

import UIKit

final class HeaderView: UIView, NibOwnerLoadable {    
    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var btnBack: IconButton!
    @IBOutlet weak var btnCart: IconButton!
    @IBOutlet private weak var lblTotalAmount: UILabel!
    @IBOutlet private weak var stackViewCart: UIStackView!
    var viewModel: HeaderViewModelProtocol = HeaderViewViewModel()
    
    init(frame: CGRect, viewModel: HeaderViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: frame)
    }
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.loadNibContent()        
    }
    
    func setViewData(viewModel: HeaderViewModelProtocol) {
        self.viewModel = viewModel
        setupUI()
        initManager()
    }
    
    private func setupUI() {
        lblTitle.text = viewModel.title
        lblTitle.isHidden = viewModel.title.isEmpty
        btnBack.isHidden = viewModel.leftButtonType.isHidden
        btnCart.iconButton(icon: "shopping-cart", iconColor: UIColor.Getir.primary, setBackgroundColor: .clear, size: .medium)
        btnBack.iconButton(icon: viewModel.leftButtonType.image, iconColor: .white, setBackgroundColor: .clear, size: .medium)
        stackViewCart.layoutMargins = UIEdgeInsets(top: 0, left: StyleConstants.Size.small, bottom: 0, right: StyleConstants.Size.small)
        stackViewCart.isLayoutMarginsRelativeArrangement = true
    }
    
    func initManager() {
        BasketManager.shared.totalAmount = updateAmount
    }
    
    func updateAmount(amount: Double) {
        lblTotalAmount.text = CurrencyManager.shared.createCurrencyString(amount: amount)
    }
    
    @IBAction func actionBackBtn(_ sender: Any) {
        viewModel.didTapDismiss?()
    }
    
    @IBAction func actionCartBtn(_ sender: Any) {
        viewModel.didTapCart?()
    }
}

