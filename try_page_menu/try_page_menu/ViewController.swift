//
//  ViewController.swift
//  try_page_menu
//
//  Created by Wataru Maeda on 2017/11/28.
//  Copyright © 2017 com.wataru.maeda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    initPageMenu()
  }
  
  func initPageMenu() {
    let viewControllers = getViewControllers()
    let pageMenu = PageMenu(
      viewControllers: viewControllers,
      option: PageMenuOption(frame: view.bounds))
    view.addSubview(pageMenu.view)
    pageMenu.didMove(toParentViewController: self)
  }
}

// MARK: - Model

extension ViewController {
  
  func getViewControllers() -> [UIViewController] {
    var viewControllers = [UIViewController]()
    for i in 1 ..< 10 {
      let viewController = getViewController(withId: i)
      viewControllers.append(viewController)
    }
    return viewControllers
  }
}

// MARK: - Supporting functions

extension ViewController {

  func getViewController(withId: Int) -> UIViewController {
    let viewController = UIViewController()
    viewController.title = "ViewController-\(withId)"
    viewController.view.backgroundColor = getRandomColor()
    return viewController
  }
  
  func getRandomColor() -> UIColor {
    let randomRed:CGFloat = CGFloat(drand48())
    let randomGreen:CGFloat = CGFloat(drand48())
    let randomBlue:CGFloat = CGFloat(drand48())
    return UIColor(red: randomRed,
                   green: randomGreen,
                   blue: randomBlue,
                   alpha: 1.0)
  }
}
