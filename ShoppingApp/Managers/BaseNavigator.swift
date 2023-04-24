//
//  BaseNavigator.swift
//  ShoppingApp
//
//  Created by isa on 26.02.2023.
//

import UIKit

class BaseNavigator {
    weak var navigationController: UINavigationController!

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
        
    func showDashboard() {
        let dashboard = DashboardViewController(viewModel: DashboardViewModel())
        navigationController.pushViewController(dashboard, animated: true)
    }
    
    func showCart() {
        let shoppingCartVC = ShoppingCartViewController(viewModel: ShoppingCartViewModel())
        present(vc: shoppingCartVC)
    }
    
    func dismiss() {
        navigationController.dismiss(animated: true)
    }
    
    func pop() {
        navigationController.popViewController(animated: true)
    }
    
    func present(vc: UIViewController, style: UIModalPresentationStyle = .fullScreen) {
        let navController = UINavigationController(rootViewController: vc)
        navController.navigationBar.isHidden = true
        navController.modalPresentationStyle = style
        navigationController.present(navController, animated: true)
    }
    
    func presentPopup(vc: UIViewController) {
        navigationController.present(vc, animated: true)
    }
   
    func showShareActivity(items: [String]) {
        let activityIndicator = UIActivityViewController(activityItems: items, applicationActivities: nil)
        presentPopup(vc: activityIndicator)
    }
}

