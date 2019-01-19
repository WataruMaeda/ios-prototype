//
//  TabBarController.swift
//  sample-tab-pageMenu
//
//  Created by Wataru Maeda on 2019-01-19.
//  Copyright © 2019 com.watarumaeda. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViewControllers()
  }
  
  func setupViewControllers() {
    var viewControllers = [UIViewController]()
    
    let tabA = TabAController()
    let tabB = ViewController()
    tabA.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
    tabB.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 1)
    
    viewControllers.append(tabA)
    viewControllers.append(tabB)
    
    tabA.addSelectedHandler {
      self.selectedIndex = 1
    }
    tabB.addSelectedHandler {
      self.selectedIndex = 0
    }
    
    self.setViewControllers(viewControllers, animated: false)
  }
}
