//
//  UIView+extension.swift
//  ShoppingApp
//
//  Created by isa on 26.02.2023.
//

import UIKit

extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}
