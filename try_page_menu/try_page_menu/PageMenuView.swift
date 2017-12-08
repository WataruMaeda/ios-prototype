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
  var menuItemHeight: CGFloat
  var menuItemWidth: CGFloat
  var menuItemBackgroundColorNormal: UIColor
  var menuItemBackgroundColorSelected: UIColor
  var menuTitleMargin: CGFloat
  var menuTitleFont: UIFont
  var menuTitleColorNormal: UIColor
  var menuTitleColorSelected: UIColor
  var menuIndicatorHeight: CGFloat
  var menuIndicatorColor: UIColor
  
  init(frame: CGRect,
       menuItemHeight: CGFloat = 44,
       menuItemWidth: CGFloat = 0,
       menuItemBackgroundColorNormal: UIColor = .white,
       menuItemBackgroundColorSelected: UIColor = .white,
       menuTitleMargin: CGFloat = 20,
       menuTitleFont: UIFont = .systemFont(ofSize: 16),
       menuTitleColorNormal: UIColor = .lightGray,
       menuTitleColorSelected: UIColor = .black,
       menuIndicatorHeight: CGFloat = 3,
       menuIndicatorColor: UIColor = .darkGray) {
    self.frame = frame
    self.menuItemHeight = menuItemHeight
    self.menuItemWidth = menuItemWidth
    self.menuItemBackgroundColorNormal = menuItemBackgroundColorNormal
    self.menuItemBackgroundColorSelected = menuItemBackgroundColorSelected
    self.menuTitleMargin = menuTitleMargin
    self.menuTitleFont = menuTitleFont
    self.menuTitleColorNormal = menuTitleColorNormal
    self.menuTitleColorSelected = menuTitleColorSelected
    self.menuIndicatorHeight = menuIndicatorHeight
    self.menuIndicatorColor = menuIndicatorColor
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
    setupBaseScrollView()
    setupMenuButtons()
    setupIndicatorBorder()
    addSubview(menuScrollView)
  }
  
  private func setupBaseScrollView() {
    menuScrollView = UIScrollView()
    menuScrollView.backgroundColor = option.menuItemBackgroundColorNormal
    menuScrollView.delegate = self
    menuScrollView.isPagingEnabled = false
    menuScrollView.showsHorizontalScrollIndicator = false
    menuScrollView.frame = CGRect(x: 0, y: 0,
                              width: frame.size.width,
                              height: option.menuItemHeight)
  }
  
  private func setupMenuButtons() {
    var menuX = 0 as CGFloat
    for i in 1...viewControllers.count {
      let viewIndex = i - 1
      
      // Menu button
      let menuButton = UIButton(type: .custom)
      menuButton.tag = i
      menuButton.setBackgroundColor(option.menuItemBackgroundColorNormal, forState: .normal)
      menuButton.setBackgroundColor(option.menuItemBackgroundColorSelected, forState: .selected)
      menuButton.setTitle(viewControllers[viewIndex].title, for: .normal)
      menuButton.setTitleColor(option.menuTitleColorNormal, for: .normal)
      menuButton.setTitleColor(option.menuTitleColorSelected, for: .selected)
      menuButton.titleLabel?.font = option.menuTitleFont
      menuButton.addTarget(self, action: #selector(selectedMenuItem(_:)), for: .touchUpInside)
      menuButton.isSelected = (viewIndex == 0)
      
      // Resize Menu item based on option
      let buttonWidth = getMenuButtonWidth(button: menuButton)
      menuButton.frame = CGRect(x: menuX, y: 0,
                                width: buttonWidth,
                                height: option.menuItemHeight)
      menuScrollView.addSubview(menuButton)
      
      // Update x position
      menuX += buttonWidth
    }
    menuScrollView.contentSize.width = menuX
  }
  
  private func setupIndicatorBorder() {
    guard let firstMenuButton = menuScrollView.viewWithTag(1) as? UIButton else { return }
    menuBorderLine = UIView()
    menuBorderLine.backgroundColor = option.menuIndicatorColor
    menuBorderLine.frame = CGRect(
      x: firstMenuButton.frame.origin.x,
      y: firstMenuButton.frame.maxY - option.menuIndicatorHeight,
      width: firstMenuButton.frame.size.width,
      height: option.menuIndicatorHeight)
    menuScrollView.addSubview(menuBorderLine)
  }
  
  func updateMenuTitle(title: String, viewIndex: Int) {
    let buttonIndex = viewIndex + 1
    guard let menuButton = menuScrollView.viewWithTag(buttonIndex)
      as? UIButton else { return }
    menuButton.setTitle(title, for: .normal)
    var rect = menuButton.frame
    rect.size.width = getMenuButtonWidth(button: menuButton)
    menuButton.frame = rect
    var minX = menuButton.frame.minX
    for i in buttonIndex...viewControllers.count {
      guard let button = menuScrollView.viewWithTag(i) as? UIButton else { continue }
      var origin = button.frame.origin
      origin.x = minX
      button.frame.origin = origin
      minX = button.frame.maxX
    }
    let currentButtonIndex = getCurrentMenuButtonIndex()
    updateIndicatorPosition(menuButtonIndex: currentButtonIndex)
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
        button.isSelected = false
      }
    }
    menuButton.isSelected = true
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
  
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    if scrollView == menuScrollView { return }
    let buttonIndex = getCurrentMenuButtonIndex()
    updateIndicatorPosition(menuButtonIndex: buttonIndex)
    updateButtonStatus(menuButtonIndex: buttonIndex)
    updateMenuScrollOffsetIfNeeded(menuButtonIndex: buttonIndex)
  }
}

// MARK: - Supporting Functions

extension PageMenuView {
  
  func getCurrentMenuButtonIndex() -> Int {
    let offsetX = collectionView.contentOffset.x
    let collectionViewWidth = collectionView.bounds.size.width
    return Int(ceil(offsetX / collectionViewWidth)) + 1
  }
  
  func getMenuButtonWidth(button: UIButton) -> CGFloat {
    var buttonWidth = 0 as CGFloat
    if option.menuItemWidth == 0 {
      // based on title text
      buttonWidth = button.sizeThatFits(
        CGSize(width: CGFloat.greatestFiniteMagnitude,
               height: option.menuItemHeight)).width + option.menuTitleMargin / 2
    } else {
      // based on specified width
      buttonWidth = option.menuItemWidth + option.menuTitleMargin / 2
    }
    return buttonWidth
  }
}

// MARK: - UIButton Extension

extension UIButton {
  
  func setBackgroundColor(_ color: UIColor, forState: UIControlState) {
    UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
    UIGraphicsGetCurrentContext()?.setFillColor(color.cgColor)
    UIGraphicsGetCurrentContext()?.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
    let colorImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    setBackgroundImage(colorImage, for: forState)
  }
}
