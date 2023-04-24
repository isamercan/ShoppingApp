//
//  AlertManager.swift
//  ShoppingApp
//
//  Created by isa on 26.02.2023.
//

import UIKit

final class AlertManager {
    
    struct PopupData {
        let title: String?
        let message: String?
        var style: UIAlertController.Style = .alert
        let actions: [PopupAction]
    }
    
    struct PopupAction {
        let resultType: ResultType
        let title: String?
        let style: UIAlertAction.Style
    }
    
    enum ResultType {
        case confirm, cancel, custom(id: String)
    }
    
    private let navigator: BaseNavigator
    
    init(navigator: BaseNavigator) {
        self.navigator = navigator
    }
    
    func showUIAlert(title: String? = nil, message: String? = nil, showRetry: Bool = false, completion: ((ResultType) -> Void)? = nil) {
        
        let errorMessage = message ?? ShoppingError.common.errorReason
        
        var actions: [PopupAction] = [.init(resultType: .confirm,
                                            title: "OK",
                                            style: .cancel)]
        
        if showRetry {
            actions.append(.init(resultType: .confirm,
                                 title: "Retry",
                                 style: .default))
        }
        
        let data = PopupData(title: title ?? ShoppingError.common.errorReason,
                             message: errorMessage,
                             actions: actions)
        
        showAlertPopup(data: data, completion: completion)
    }
    
    func showAlertPopup(data: PopupData, completion: ((ResultType) -> Void)? = nil)  {
        let alertController = UIAlertController(title: data.title,
                                                message: data.message,
                                                preferredStyle: data.style)
        
        for action in data.actions {
            let alertAction = UIAlertAction(title: action.title,
                                            style: action.style) {  _ in
                completion?(action.resultType)
            }
            alertController.addAction(alertAction)
        }
        navigator.presentPopup(vc: alertController)
    }
}
