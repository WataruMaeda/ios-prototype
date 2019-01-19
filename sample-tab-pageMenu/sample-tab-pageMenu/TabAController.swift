//
//  TabAController.swift
//  sample-tab-pageMenu
//
//  Created by Wataru Maeda on 2019-01-19.
//  Copyright © 2019 com.watarumaeda. All rights reserved.
//

import UIKit

class TabAController: UIViewController {
  
  var callback: () -> Void = {}
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setupPageMenu()
  }
  
  func setupPageMenu() {
    
    let viewControllerA = ViewControllerA()
    viewControllerA.title = "ViewControlerA"
    viewControllerA.addSelectedHandler {
      self.callback()
    }
    
    let viewControllerB = ViewControllerB()
    viewControllerB.title = "ViewControlerB"
    
    let viewControllers = [viewControllerA, viewControllerB]
    
    let option = PageMenuOption(frame: CGRect(
      x: 0, y: 40, width: view.frame.size.width, height: view.frame.size.height - 40))
    
    let pageMenu = PageMenuView(viewControllers: viewControllers, option: option)
    view.addSubview(pageMenu)
  }
  
  func addSelectedHandler(callback: @escaping () -> Void = {}) {
    self.callback = callback
  }
  
}
