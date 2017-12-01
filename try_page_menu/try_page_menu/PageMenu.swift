//
//  PageMenu.swift
//  try_page_menu
//
//  Created by Wataru Maeda on 2017/11/29.
//  Copyright © 2017 com.wataru.maeda. All rights reserved.
//

import UIKit

struct PageMenuOption {
  
  var frame: CGRect
  var menuItemHeight: CGFloat?
  var menuItemsWidth: CGFloat?
  var menuTitleInset: UIEdgeInsets?
  var menuBorderHeight: CGFloat?
  
  init(frame: CGRect,
       menuItemHeight: CGFloat = 40,
       menuItemsWidth: CGFloat = 0,
       menuTitleInset: UIEdgeInsets = .zero,
       menuBorderHeight: CGFloat = 2
       ) {
    self.frame = frame
    self.menuItemHeight = menuItemHeight
    self.menuItemsWidth = menuItemsWidth
    self.menuTitleInset = menuTitleInset
    self.menuBorderHeight = menuBorderHeight
  }
}

class PageMenu: UIViewController {

  // MARK: - Model
  
  fileprivate var viewControllers = [UIViewController]()
  
  fileprivate var option = PageMenuOption(frame: UIScreen.main.bounds)
  
  // MARK: - View
  
  fileprivate lazy var collectionView: UICollectionView = {
    let cv = UICollectionView()
    cv.dataSource = self
    cv.delegate = self
    return cv
  }()
  
  fileprivate lazy var scrollView: UIScrollView = {
    let scroll = UIScrollView()
    scroll.delegate = self
    scroll.isPagingEnabled = false
    scroll.isUserInteractionEnabled = false
    return scroll
  }()
  
  fileprivate lazy var menuBorderLine = UIView()
  
  // MARK: - Life Cycle
  
  convenience init() {
    self.init(viewControllers: [], option: PageMenuOption(frame: .zero))
  }
  
  init(viewControllers: [UIViewController], option: PageMenuOption) {
    super.init(nibName: nil, bundle: nil)
    self.viewControllers = viewControllers
    self.option = option
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}

// MARK: - Controller

extension PageMenu {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(scrollView)
    view.addSubview(collectionView)
  }
}

// MARK: - Menu Items (ScrollView)

extension PageMenu: UIScrollViewDelegate {
  
  fileprivate func setupMenuItems() {
    
    // Resize scroll view based on screen width
    setupBaseScrollView()
    
    // Setup Menu Buttons
    setupMenuButtons()
    
    // Setup borderline
    setupBorderline()
  }
  
  private func setupBaseScrollView() {
    scrollView.frame = CGRect(x: 0, y: 0,
                              width: view.frame.size.width,
                              height: option.menuItemHeight ?? 40)
  }
  
  private func setupMenuButtons() {
    var menuX = 0 as CGFloat
    for i in 0..<viewControllers.count {
      // Init Menu button
      let menuButton = UIButton()
      menuButton.tag = i
      menuButton.titleEdgeInsets = option.menuTitleInset ?? .zero
      menuButton.setTitle(viewControllers[i].title, for: .normal)
      
      // Resize Menu item based on option
      let buttonSize = menuButton.sizeThatFits(
        CGSize(width: CGFloat.greatestFiniteMagnitude,
               height: option.menuItemHeight!))
      menuButton.frame = CGRect(x: menuX, y: 0,
                                width: buttonSize.width,
                                height: buttonSize.height)
      menuX += buttonSize.width
      scrollView.addSubview(menuButton)
    }
    scrollView.contentSize.width = menuX
  }
  
  private func setupBorderline() {
    guard let firstMenuButton = scrollView.viewWithTag(0) as? UIButton else { return }
    menuBorderLine.backgroundColor = .darkGray
    menuBorderLine.frame = CGRect(
      x: firstMenuButton.frame.origin.x,
      y: firstMenuButton.frame.maxY,
      width: firstMenuButton.frame.size.width,
      height: 2)
  }
  
  func updateMenuTitle(title: String, menuIndex: Int) {
    
  }
}

// MARK: - Item (CollectionView)

extension PageMenu: UICollectionViewDelegate, UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    return UICollectionViewCell()
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewControllers.count
  }
}
