//
//  UIView+Ext.swift
//  try_twitter_app
//
//  Created by Wataru Maeda on 2018/01/15.
//  Copyright © 2018 com.watarumaeda. All rights reserved.
//

import UIKit

// MARK: - Size

extension UIView {
  
  var viewWidth: CGFloat {
    get { return frame.size.width }
  }
  
  var viewHeight: CGFloat {
    get { return frame.size.height }
  }
}

// MARK: - Anchor

extension UIView {
  
  func fillAnchor() {
    translatesAutoresizingMaskIntoConstraints = false
    if let superview = superview {
      leftAnchor.constraint(equalTo: superview.leftAnchor).isActive = true
      rightAnchor.constraint(equalTo: superview.rightAnchor).isActive = true
      topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
      bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
    }
  }
  
  func anchor(_ top: NSLayoutYAxisAnchor? = nil,
              left: NSLayoutXAxisAnchor? = nil,
              bottom: NSLayoutYAxisAnchor? = nil,
              right: NSLayoutXAxisAnchor? = nil,
              topConstant: CGFloat = 0,
              leftConstant: CGFloat = 0,
              bottomConstant: CGFloat = 0,
              rightConstant: CGFloat = 0,
              widthConstant: CGFloat = 0,
              heightConstant: CGFloat = 0) {
    translatesAutoresizingMaskIntoConstraints = false
    _ = anchorWithReturnAnchors(top,
                                left: left,
                                bottom: bottom,
                                right: right,
                                topConstant: topConstant,
                                leftConstant: leftConstant,
                                bottomConstant: bottomConstant,
                                rightConstant: rightConstant,
                                widthConstant: widthConstant,
                                heightConstant: heightConstant)
  }
  
  func anchorWithReturnAnchors(_ top: NSLayoutYAxisAnchor? = nil,
                               left: NSLayoutXAxisAnchor? = nil,
                               bottom: NSLayoutYAxisAnchor? = nil,
                               right: NSLayoutXAxisAnchor? = nil,
                               topConstant: CGFloat = 0,
                               leftConstant: CGFloat = 0,
                               bottomConstant: CGFloat = 0,
                               rightConstant: CGFloat = 0,
                               widthConstant: CGFloat = 0,
                               heightConstant: CGFloat = 0) -> [NSLayoutConstraint] {
    translatesAutoresizingMaskIntoConstraints = false
    var anchors = [NSLayoutConstraint]()
    
    if let top = top {
      anchors.append(topAnchor.constraint(equalTo: top, constant: topConstant))
    }
    
    if let left = left {
      anchors.append(leftAnchor.constraint(equalTo: left, constant: leftConstant))
    }
    
    if let bottom = bottom {
      anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant))
    }
    
    if let right = right {
      anchors.append(rightAnchor.constraint(equalTo: right, constant: -rightConstant))
    }
    
    if widthConstant > 0 {
      anchors.append(widthAnchor.constraint(equalToConstant: widthConstant))
    }
    
    if heightConstant > 0 {
      anchors.append(heightAnchor.constraint(equalToConstant: heightConstant))
    }
    anchors.forEach({$0.isActive = true})
    
    return anchors
  }
}

