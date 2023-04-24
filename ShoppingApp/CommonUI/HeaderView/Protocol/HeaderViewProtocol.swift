//
//  HeaderViewProtocol.swift
//  ShoppingApp
//
//  Created by isa on 26.02.2023.
//

import Foundation
enum HeaderViewLeftButtonType {
    case back
    case close
    case none
    
    var isHidden: Bool {
        switch self {
        case .none:
            return true
        default:
            return false
        }
    }
    var image: String {
        switch self {
        case .back:
            return "angle-left"
        case .close:
            return "cross"
        case .none:
            return "none"
        }
    }
}

protocol HeaderViewModelProtocol: AnyObject {
    var title: String { get }
    var leftButtonType: HeaderViewLeftButtonType { get }
    var didTapCart: (() -> Void)? { get set }
    var didTapDismiss: (() -> Void)? { get set }
}
