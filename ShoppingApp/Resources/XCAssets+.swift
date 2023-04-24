//
//  XCAssets+.swift
//  ShoppingApp
//
//  Created by isa on 26.02.2023.
//

import UIKit

extension UIColor {
  struct Getir {
      static var primary: UIColor  { return UIColor(named: "primaryColor") ?? .black }
      static var secondary: UIColor  { return UIColor(named: "secondaryColor") ?? .black }
      static var darkText: UIColor  { return UIColor(named: "darkText") ?? .darkText }
      static var grayText: UIColor  { return UIColor(named: "grayText") ?? .lightText }
      static var disabledText: UIColor  { return UIColor(named: "disabledText") ?? .lightGray }
      static var success: UIColor  { return UIColor(named: "success") ?? .green }
      static var warning: UIColor  { return UIColor(named: "warning") ?? .red }
  }
}
