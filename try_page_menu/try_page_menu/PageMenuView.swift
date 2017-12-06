//
//  PageMenu.swift
//  try_page_menu
//
//  Created by Wataru Maeda on 2017/11/29.
//  Copyright © 2017 com.wataru.maeda. All rights reserved.
//

import UIKit

let cellId = "PageMenuCell"

// MARK: - Page Menu Option

struct PageMenuOption {
  
  var frame: CGRect
  var menuItemHeight: CGFloat?
  var menuItemWidth: CGFloat?
  var menuTitleMargin: CGFloat?
  var menuIndicatorHeight: CGFloat?
  
  init(frame: CGRect,
       menuItemHeight: CGFloat = 44,
       menuItemWidth: CGFloat = 0,
       menuTitleMargin: CGFloat = 20,
       menuIndicatorHeight: CGFloat = 3
       ) {
    self.frame = frame
    self.menuItemHeight = menuItemHeight
    self.menuItemWidth = menuItemWidth
    self.menuTitleMargin = menuTitleMargin
    self.menuIndicatorHeight = menuIndicatorHeight
  }
}

// MARK: - Page Menu

class PageMenuView: UIView {

  private var option = PageMenuOption(frame: .zero)
  fileprivate var viewControllers = [UIViewController]()
  
  fileprivate var menuScrollView: UIScrollView!
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

// MARK: - Scroll View

extension PageMenuView: UIScrollViewDelegate {
  
  fileprivate func setupMenus() {
    
    // Resize scroll view based on screen width
    setupBaseScrollView()
    
    // Setup Menu Buttons
    setupMenuButtons()
    
    // Setup borderline
    setupIndicatorBorder()
    
    // Add Subview
    addSubview(menuScrollView)
  }
  
  private func setupBaseScrollView() {
    menuScrollView = UIScrollView()
    menuScrollView.backgroundColor = .white
    menuScrollView.delegate = self
    menuScrollView.isPagingEnabled = false
    menuScrollView.showsHorizontalScrollIndicator = false
    menuScrollView.frame = CGRect(x: 0, y: 0,
                              width: frame.size.width,
                              height: option.menuItemHeight ?? 44)
  }
  
  private func setupMenuButtons() {
    var menuX = 0 as CGFloat
    for i in 1...viewControllers.count {
      let viewIndex = i - 1
      
      // Menu button
      let menuButton = UIButton(type: .custom)
      menuButton.tag = i
      menuButton.setTitle(viewControllers[viewIndex].title, for: .normal)
      menuButton.setTitleColor((viewIndex == 0) ? .black : .lightGray, for: .normal)
      menuButton.addTarget(self, action: #selector(selectedMenuItem(_:)), for: .touchUpInside)
      
      // Resize Menu item based on option
      var buttonWidth = 0 as CGFloat
      if option.menuItemWidth == 0 {
        // based on title text
        buttonWidth = menuButton.sizeThatFits(
          CGSize(width: CGFloat.greatestFiniteMagnitude,
                 height: option.menuItemHeight!)).width + option.menuTitleMargin! / 2
      } else {
        // based on specified width
        buttonWidth = option.menuItemWidth! + option.menuTitleMargin! / 2
      }
      menuButton.frame = CGRect(x: menuX, y: 0,
                                width: buttonWidth,
                                height: option.menuItemHeight!)
      menuScrollView.addSubview(menuButton)
      
      // Update x position
      menuX += buttonWidth
    }
    menuScrollView.contentSize.width = menuX
  }
  
  private func setupIndicatorBorder() {
    guard let firstMenuButton = menuScrollView.viewWithTag(1) as? UIButton else { return }
    menuBorderLine = UIView()
    menuBorderLine.backgroundColor = .darkGray
    menuBorderLine.frame = CGRect(
      x: firstMenuButton.frame.origin.x,
      y: firstMenuButton.frame.maxY - option.menuIndicatorHeight!,
      width: firstMenuButton.frame.size.width,
      height: option.menuIndicatorHeight!)
    menuScrollView.addSubview(menuBorderLine)
  }
  
  func updateMenuTitle(title: String, menuButtonIndex: Int) {
    
  }
  
  private func updateIndicatorPosition(menuButtonIndex: Int) {
    guard let menuButton = menuScrollView.viewWithTag(menuButtonIndex) else { return }
    var rect = menuBorderLine.frame
    rect.origin.x = menuButton.frame.minX
    rect.size.width = menuButton.frame.size.width
    UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseIn], animations: {
      self.menuBorderLine.frame = rect
    }, completion: nil)
  }
  
  private func updateButtonStatus(menuButtonIndex: Int) {
    guard let menuButton = menuScrollView.viewWithTag(menuButtonIndex) as? UIButton else { return }
    for subview in menuScrollView.subviews {
      if let button = subview as? UIButton {
        button.setTitleColor(.lightGray, for: .normal)
      }
    }
    menuButton.setTitleColor(.darkGray, for: .normal)
  }
  
  private func updateMenuScrollOffsetIfNeeded(menuButtonIndex: Int) {
    guard let menuButton = menuScrollView.viewWithTag(menuButtonIndex) else { return }
    let collectionPagingWidth = collectionView.frame.size.width
    let currentMenuOffsetMinX = menuScrollView.contentOffset.x
    let currentMenuOffsetMaxX = currentMenuOffsetMinX + collectionPagingWidth
    let selectedButtonMinX = menuButton.frame.minX
    let selectedButtonMaxX = menuButton.frame.maxX
    if selectedButtonMinX < currentMenuOffsetMinX {
      // out of screen (left)
      UIView.animate(withDuration: 0.3, delay: 0.0, options: [.curveEaseIn], animations: {
        self.menuScrollView.contentOffset.x = selectedButtonMinX
      }, completion: nil)
    } else if selectedButtonMaxX > currentMenuOffsetMaxX {
      // out of screen (right)
      UIView.animate(withDuration: 0.3, delay: 0.0, options: [.curveEaseIn], animations: {
        let newOffsetX = selectedButtonMinX - (collectionPagingWidth - menuButton.frame.size.width)
        self.menuScrollView.contentOffset.x = newOffsetX
      }, completion: nil)
    }
  }
  
  @objc func selectedMenuItem(_ sender: UIButton) {
    let buttonIndex = sender.tag
    let viewIndex = sender.tag - 1
    updateIndicatorPosition(menuButtonIndex: buttonIndex)
    updateButtonStatus(menuButtonIndex: buttonIndex)
    updateMenuScrollOffsetIfNeeded(menuButtonIndex: buttonIndex)
    collectionView.scrollToItem(
      at: IndexPath.init(row: viewIndex, section: 0),
      at: .left,
      animated: true)
  }
}

// MARK: - Collection View

extension PageMenuView: UICollectionViewDelegate, UICollectionViewDataSource {
  
  func setupPageView() {
    // CollectionView Layout
    let collectionViewHeight = frame.size.height - menuScrollView.frame.maxY
    let collectionViewLayout = UICollectionViewFlowLayout()
    collectionViewLayout.scrollDirection = .horizontal
    collectionViewLayout.minimumInteritemSpacing = 0
    collectionViewLayout.minimumLineSpacing = 0
    collectionViewLayout.sectionInset = .zero
    collectionViewLayout.itemSize = CGSize(
      width: frame.size.width,
      height: collectionViewHeight)
    
    // CollectionView
    collectionView = UICollectionView(
      frame: CGRect(x: 0,
                    y: menuScrollView.frame.maxY,
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
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
    guard let controllerView = viewControllers[indexPath.row].view else {
      return UICollectionViewCell()
    }
    controllerView.frame = cell.bounds
    cell.addSubview(controllerView)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewControllers.count
  }
}

// MARK: - Scroll View (Menu Items)

extension PageMenuView {
  
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    if scrollView == menuScrollView { return }
    let offsetX = scrollView.contentOffset.x
    let collectionViewWidth = scrollView.bounds.size.width
    let buttonIndex = Int(ceil(offsetX / collectionViewWidth)) + 1
    updateIndicatorPosition(menuButtonIndex: buttonIndex)
    updateButtonStatus(menuButtonIndex: buttonIndex)
    updateMenuScrollOffsetIfNeeded(menuButtonIndex: buttonIndex)
  }
}
