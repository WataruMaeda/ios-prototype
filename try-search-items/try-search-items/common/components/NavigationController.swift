//
//  NavigationController.swift
//  Copyright © 2018 wataru maeda. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  func setupTheme(_ barTintColor: UIColor = .darkGray,
                  barStyle: UIBarStyle = .black,
                  tintColor: UIColor = .white,
                  isTranslucent: Bool = false) {
    
    delegate = self
    
    // Navigation bar background color
    navigationBar.barTintColor = barTintColor
    
    // Change Button, label text color
    navigationBar.barStyle = barStyle
    navigationBar.tintColor = tintColor
    
    // Navigation controller title color
    navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    navigationBar.isTranslucent = false
  }
}

// MARK: - UINavigationControllerDelegate

extension NavigationController: UINavigationControllerDelegate {
  
  func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
  }
}

// MARK: - Supporting Functions

extension NavigationController {
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
}
