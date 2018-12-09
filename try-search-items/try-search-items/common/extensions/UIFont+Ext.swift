//
//  UIFont+Ext.swift
//  Copyright © 2018 wataru maeda. All rights reserved.
//

import UIKit

extension UIFont {
  
  static func keyLightFont(size: CGFloat) -> UIFont {
    if let font = UIFont(name: "SFUIText-Light", size: size) {
      return font
    }
    return UIFont.systemFont(ofSize: size, weight: .light)
  }
  
  static func keyMediumFont(size: CGFloat) -> UIFont {
    if let font = UIFont(name: "SFUIText-Medium", size: size) {
      return font
    }
    return UIFont.systemFont(ofSize: size, weight: .medium)
  }
  
  static func keyBoldFont(size: CGFloat) -> UIFont {
    if let font = UIFont(name: "SFUIText-Bold", size: size) {
      return font
    }
    return UIFont.systemFont(ofSize: size, weight: .bold)
  }
}

