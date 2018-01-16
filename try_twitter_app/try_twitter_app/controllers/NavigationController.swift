//
//  NavigationController.swift
//  try_twitter_app
//
//  Created by Wataru Maeda on 2018/01/15.
//  Copyright © 2018 com.watarumaeda. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTheme()
  }
  
  private func setupTheme() {
    
    // Navigation bar background color
    navigationBar.barTintColor = .flatDarkGray
    
    // Change Button, label text color
    navigationBar.barStyle = UIBarStyle.black
    navigationBar.tintColor = UIColor.white
    
    // Navigation controller title color
    navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    navigationBar.isTranslucent = false
  }
}
