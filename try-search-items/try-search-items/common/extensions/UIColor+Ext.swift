//
//  UIColor+Ext.swift
//  Copyright © 2018 wataru maeda. All rights reserved.
//

import UIKit

extension UIColor {
  
  static let keyColor = UIColor("#525c67")
  
}

extension UIColor {
  
  convenience init(_ hex: String) {
    
    let hex: String = (hex as NSString).trimmingCharacters(in: .whitespacesAndNewlines)
    let scanner = Scanner(string: hex as String)
    
    if hex.hasPrefix("#") {
      scanner.scanLocation = 1
    }
    var color: UInt32 = 0
    scanner.scanHexInt32(&color)
    
    let mask = 0x000000FF
    let r = Int(color >> 16) & mask
    let g = Int(color >> 8) & mask
    let b = Int(color) & mask
    
    let red = CGFloat(r) / 255.0
    let green = CGFloat(g) / 255.0
    let blue = CGFloat(b) / 255.0
    self.init(red: red, green: green, blue: blue, alpha: 1)
  }
}
