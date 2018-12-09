//
//  UIViewController+Ext.swift
//  Copyright © 2018 wataru maeda. All rights reserved.
//

import UIKit

// MARK: - Size

extension UIViewController {
  
  var statusHeight: CGFloat {
    get { return UIApplication.shared.statusBarFrame.size.height }
  }
  
  var navigationHeigt: CGFloat {
    get { return navigationController?.navigationBar.frame.size.height ?? 0 }
  }
  
  var tabBarHeigt: CGFloat {
    get { return tabBarController?.tabBar.frame.size.height ?? 0 }
  }
}

// MARK: - ViewController

extension UIViewController {
  
  static var topViewController: UIViewController? {
    get {
      if var root = UIApplication.shared.keyWindow?.rootViewController {
        while let presented = root.presentedViewController {
          root = presented
        }
        return root
      }
      return nil
    }
  }
}

// MARK: - Navigation configuretion

extension UIViewController {
  
  func configureNavigationClose(_ callback: @escaping ()->Void) {
    
    // generate navi close button
    let button = UIButtonCallback()
    button.handleTap(event: .touchUpInside, callback: { _ in
      callback()
    })
    
    // add as navigation button
    navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
  }
  
 }
