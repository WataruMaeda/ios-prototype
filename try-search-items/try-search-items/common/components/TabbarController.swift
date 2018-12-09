//
//  TabbarController.swift
//  Copyright © 2017 Wataru Maeda. All rights reserved.
//

import UIKit

class TabbarController: UITabBarController {
  
  fileprivate var isTabPresenting = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViewControllers()
    setupTheme()
  }
}

// MARK: - UI

extension TabbarController {
  
  fileprivate func setupViewControllers() {
    
    delegate = self
    
    // init view controllers
    let viewController1 = UIViewController()
    let viewController2 = UIViewController()
    
    // setting tab items
    viewController1.tabBarItem = UITabBarItem(
      title: "Home",
      image: UIImage().withRenderingMode(.alwaysTemplate),
      tag: 0
    )
    viewController2.tabBarItem = UITabBarItem(
      title: "Timeline",
      image: UIImage().withRenderingMode(.alwaysTemplate),
      tag: 1
    )
    
    // wrap with navigation controller
    let navigationContoller1 = NavigationController(rootViewController: viewController1)
    let navigationContoller2 = NavigationController(rootViewController: viewController2)
    
    // set in view controllers array
    viewControllers = [navigationContoller1, navigationContoller2]
    isTabPresenting = true
    selectedIndex = 0
  }
  
  fileprivate func setupTheme() {
    
    // background color
    tabBar.barTintColor = .white
    
    // icon tint color
    tabBar.tintColor = .black
    
    // title color
    tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.keyColor], for:.normal)
    tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.black], for:.selected)
    
    // selected background color
    tabBar.selectionIndicatorImage = UIImage()
  }
}

// MARK: - Action

extension TabbarController: UITabBarControllerDelegate {
  
  // MARK: UITabBarControllerDelegate
  
  func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
  }
}

// MARK: - Animation

extension TabbarController {
  
  internal func showTab() {
    
    isTabPresenting = true
    var frm = tabBar.frame
    frm.origin.y = view.frame.size.height - frm.size.height
    UIView.animate(withDuration: 0.5, animations: {
      self.tabBar.frame = frm
    })
  }
  
  internal func hideTab() {
    
    isTabPresenting = false
    var frm = tabBar.frame
    frm.origin.y = view.frame.size.height
    UIView.animate(withDuration: 0.5, animations: {
      self.tabBar.frame = frm
    })
  }
}
