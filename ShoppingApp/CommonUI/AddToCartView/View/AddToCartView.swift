//
//  AddToCartView.swift
//  ShoppingApp
//
//  Created by isa on 27.02.2023.
//

import UIKit

final class AddToCartView: UIView, NibOwnerLoadable {
    @IBOutlet private weak var btnPlus: IconButton!
    @IBOutlet private weak var btnMinus: IconButton!
    @IBOutlet private weak var lblQty: UILabel!
    @IBOutlet private weak var stackViewCart: UIStackView!
    @IBOutlet private weak var btnUpdateCart: UIButton!
    
    var viewModel: AddToCartViewModelProtocol = AddToCartViewModel(product: nil)
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.loadNibContent()
    }
    
    func setViewData(viewModel: AddToCartViewModelProtocol) {
        self.viewModel = viewModel
        setupUI()
    }
    
    private func setupUI() {
        lblQty.text = "\(viewModel.product?.qty ?? 0)"
        btnMinus.isEnabled = viewModel.isInBasket
        btnPlus.iconButton(icon: "plus", iconColor: .white, setBackgroundColor: UIColor.Getir.primary, size: .medium)
        btnMinus.iconButton(icon: "minus",
                            iconColor: viewModel.isInBasket ? .white : UIColor.Getir.disabledText,
                            setBackgroundColor: viewModel.isInBasket ? UIColor.Getir.primary : UIColor.Getir.grayText,
                            size: .medium)
    }
    
    func updateAmount(product: ProductModel) {
        viewModel.product = product
        lblQty.text = String(product.qty ?? 0)
        btnMinus.isEnabled = viewModel.isInBasket
        
        btnMinus.iconButton(icon: "minus",
                            iconColor: viewModel.isInBasket ? .white : UIColor.Getir.disabledText,
                            setBackgroundColor: viewModel.isInBasket ? UIColor.Getir.primary : UIColor.Getir.grayText,
                            size: .medium)
    }
    
    @IBAction func actionCartBtns(_ sender: UIButton) {
        if sender.tag == 0 {
            viewModel.updateCartItemClosure?(false)
        } else if sender.tag == 1 {
            viewModel.updateCartItemClosure?(true)
        }
    }
}
