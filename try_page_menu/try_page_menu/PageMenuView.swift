//
//  PageMenu.swift
//  try_page_menu
//
//  Created by Wataru Maeda on 2017/11/29.
//  Copyright © 2017 com.wataru.maeda. All rights reserved.
//

import UIKit

let cellId = "PageMenuCell"

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

class PageMenu: UIView {

  fileprivate var option = PageMenuOption(frame: UIScreen.main.bounds)
  fileprivate var viewControllers = [UIViewController]()
  
  fileprivate var scrollView: UIScrollView!
  fileprivate var menuBorderLine: UIView!
  fileprivate var collectionView: UICollectionView!
  
  convenience init() {
    self.init(viewControllers: [], option: PageMenuOption(frame: .zero))
  }
  
  init(viewControllers: [UIViewController], option: PageMenuOption) {
    super.init(frame: option.frame)
    self.viewControllers = viewControllers
    self.option = option
    backgroundColor = .white
    setupMenus()
    setupPageView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}

// MARK: - Controller

extension PageMenu {
}

// MARK: - ScrollView (Menu Items)

extension PageMenu: UIScrollViewDelegate {
  
  fileprivate func setupMenus() {
    
    // Resize scroll view based on screen width
    setupBaseScrollView()
    
    // Setup Menu Buttons
    setupMenuButtons()
    
    // Setup borderline
    setupBorderline()
    
    // Add Subview
    addSubview(scrollView)
  }
  
  private func setupBaseScrollView() {
    scrollView = UIScrollView()
    scrollView.backgroundColor = .white
    scrollView.delegate = self
    scrollView.isPagingEnabled = false
    scrollView.frame = CGRect(x: 0, y: 0,
                              width: frame.size.width,
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
      menuButton.setTitleColor(.black, for: .normal)
      menuButton.addTarget(self, action: #selector(selectedMenuItem(_:)), for: .touchUpInside)
      
      // Resize Menu item based on option
      let buttonSize = menuButton.sizeThatFits(
        CGSize(width: CGFloat.greatestFiniteMagnitude,
               height: option.menuItemHeight!))
      menuButton.frame = CGRect(x: menuX, y: 0,
                                width: buttonSize.width,
                                height: option.menuItemHeight!)
      scrollView.addSubview(menuButton)
      
      // Update x position
      menuX += buttonSize.width
    }
    scrollView.contentSize.width = menuX
  }
  
  private func setupBorderline() {
    guard let firstMenuButton = scrollView.viewWithTag(0) as? UIButton else { return }
    menuBorderLine = UIView()
    menuBorderLine.backgroundColor = .darkGray
    menuBorderLine.frame = CGRect(
      x: firstMenuButton.frame.origin.x,
      y: firstMenuButton.frame.maxY,
      width: firstMenuButton.frame.size.width,
      height: 2)
  }
  
  func updateMenuTitle(title: String, menuIndex: Int) {
    
  }
  
  @objc func selectedMenuItem(_ sender: UIButton) {
    print("tspped Menu Item (\(sender.titleLabel?.text ?? "")")
  }
}

// MARK: - CollectionView (Page View)

extension PageMenu: UICollectionViewDelegate, UICollectionViewDataSource {
  
  func setupPageView() {
    // CollectionView Layout
    let collectionViewHeight = frame.size.height - scrollView.frame.maxY
    let collectionViewLayout = UICollectionViewFlowLayout()
    collectionViewLayout.scrollDirection = .horizontal
    collectionViewLayout.minimumLineSpacing = 0
    collectionViewLayout.minimumInteritemSpacing = 0
    collectionViewLayout.sectionInset = .zero
    collectionViewLayout.itemSize = CGSize(
      width: frame.size.width,
      height: collectionViewHeight)
    
    // CollectionView
    collectionView = UICollectionView(
      frame: CGRect(x: 0,
                    y: scrollView.frame.maxY,
                    width: frame.size.width,
                    height: collectionViewHeight),
      collectionViewLayout: collectionViewLayout)
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.isPagingEnabled = true
    collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    addSubview(collectionView)
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(
                  withReuseIdentifier: cellId, for: indexPath)
    let viewController = viewControllers[indexPath.row]
    cell.addSubview(viewController.view)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewControllers.count
  }
}
