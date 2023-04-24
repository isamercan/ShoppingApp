//
//  UIViewController+extension.swift
//  ShoppingApp
//
//  Created by isa on 26.02.2023.
//

import UIKit

extension UIViewController {
    static func loadFromNib() -> Self {
        return Self.init(nibName: String(describing: self), bundle: nil)
    }
}

