//
//  FirstTutorialViewController.swift
//  try-tutorial
//
//  Created by Wataru Maeda on 2018-07-03.
//  Copyright © 2018 com.watarumaeda. All rights reserved.
//

import UIKit

class FirstTutorialViewController: UIViewController {
  
  fileprivate var users = [User]()
  @IBOutlet weak var collectionView: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    title = ""
    setupNavigationItems()
    setUserList()
    setupCollectionView()
    setupPager()
    showSpeechBaloon()
  }
}

// MARK: - Model

extension FirstTutorialViewController {
  
  func setUserList() {
    users = TutorialModelManager.getUserList() ?? [User]()
  }
}

// MARK: - NavigationItem

extension FirstTutorialViewController {
  
  fileprivate func setupNavigationItems() {
    let searchBar = UISearchBar()
    searchBar.tintColor = .darkGray
    searchBar.placeholder = "メイク・コスメ・ユーザーを検索"
    searchBar.isUserInteractionEnabled = false
    navigationItem.titleView = searchBar
  }
}

// MARK: - Speech Baloon

extension FirstTutorialViewController {
  
  func showSpeechBaloon() {
    
    // get nib
    let nib = UINib(nibName: "TutorialSpeechBaloon", bundle: nil)
    let subviews = nib.instantiate(withOwner: self, options: nil)
    
    // show baloon after 4 sec
    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
      
      // first cell position
      let indexPath = IndexPath(row: 0, section: 0)
      guard let attribute = self.collectionView.layoutAttributesForItem(at: indexPath) else {
        return
      }
      
      // create baloon
      let speechBaloonView = subviews.first as! TutorialSpeechBaloon
      speechBaloonView.frame = CGRect(x: attribute.frame.origin.x + attribute.frame.size.width / 3 * 2,
                                           y: attribute.frame.origin.y + attribute.frame.size.height / 4,
                                           width: self.view.frame.size.width / 3,
                                           height: self.view.frame.size.width / 3)
      speechBaloonView.label.text = "参考にしたい人を\n見つけよう"
      speechBaloonView.alpha = 0
      self.view.addSubview(speechBaloonView)
      
      // animation
      UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseIn], animations: {
        
        // fade in animation
        speechBaloonView.alpha = 1
        
      }, completion: { _ in
        
        guard let cell = self.collectionView.cellForItem(at: indexPath) else { return }
        
        // shake animation
        let animation = CAKeyframeAnimation(keyPath:"transform")
        let angle = 0.05 as CGFloat
        animation.values = [CATransform3DMakeRotation(angle, 0.0, 0.0, 1.0),
                            CATransform3DMakeRotation(-angle, 0.0, 0.0, 1.0)]
        animation.autoreverses = true
        animation.duration = 0.2
        animation.repeatCount = 1
        cell.layer.add(animation, forKey: "position")
      })
    }
  }
}

// MARK: - Page Control

extension FirstTutorialViewController {
  
  func setupPager() {
    
    // get pager from xib
    let nib = UINib(nibName: "TutorialPager", bundle: nil)
    let subviews = nib.instantiate(withOwner: self, options: nil)
    guard let pager = subviews.first as? TutorialPager else { return }
    pager.frame = CGRect(x: 0, y: view.frame.size.height,
                         width: view.frame.size.width, height: 178)
    
    // add skip action
    pager.skipButton.addTarget(self,action: #selector(tappedSkip), for: .touchUpInside)
    
    // setup shadow
    pager.layer.shadowColor = UIColor.lightGray.cgColor
    pager.layer.shadowOffset = CGSize(width: 0, height: -1);
    pager.layer.masksToBounds = false
    pager.layer.shadowOpacity = 0.2
    
    // setup contents
    pager.setupContents(1)
    
    view.addSubview(pager)
    
    // animation
    var pagerOrigin = pager.frame.origin
    pagerOrigin.y = view.frame.size.height - 178
    UIView.animate(withDuration: 0.2, delay: 2, options: [.curveEaseIn], animations: {
      pager.frame.origin = pagerOrigin
    }, completion: nil)
  }
  
  @objc func tappedSkip() {
    let storyboard = UIStoryboard(name: "Tutorial", bundle: Bundle.main)
    let secondTutorial = storyboard.instantiateViewController(withIdentifier: "SecondTutorialViewController")
    navigationController?.pushViewController(secondTutorial, animated: true)
  }
}

// MARK: - CollectionView

extension FirstTutorialViewController: UICollectionViewDataSource, UICollectionViewDelegate {
  
  fileprivate func setupCollectionView() {
    
    // set collection view UI
    collectionView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0)
    
    // set layout of collectionView
    let space = 10 as CGFloat
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.minimumLineSpacing = space
    flowLayout.minimumInteritemSpacing = space / 2
    flowLayout.sectionInset = UIEdgeInsetsMake(0, space, space, space);
    flowLayout.headerReferenceSize = CGSize(
      width: view.frame.size.width,
      height: 70
    )
    flowLayout.itemSize = CGSize(
      width: (view.frame.size.width - space * 4) / 3,
      height: (view.frame.size.width - space * 4) / 3 * 1.3
    )
    collectionView.setCollectionViewLayout(flowLayout, animated: true, completion: nil)
    
    // set delegate & datasorce
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.isScrollEnabled = false
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    return users.count
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? TutorialUserCell else {
      return UICollectionViewCell()
    }
    let index = indexPath.row
    cell.setupContens(users[index], index: index)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      viewForSupplementaryElementOfKind kind: String,
                      at indexPath: IndexPath) -> UICollectionReusableView {
    
    guard let header = collectionView.dequeueReusableSupplementaryView(
      ofKind: UICollectionElementKindSectionHeader,
      withReuseIdentifier: "TutorialSwitchReusableView",
      for: indexPath) as? TutorialSwitchReusableView else {
      fatalError("Could not find proper header")
    }
    header.isUserInteractionEnabled = false
    
    return kind == UICollectionElementKindSectionHeader ? header : UICollectionReusableView()
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if indexPath.row != 0 { return }
    let storyboard = UIStoryboard(name: "Tutorial", bundle: Bundle.main)
    let secondTutorial = storyboard.instantiateViewController(withIdentifier: "SecondTutorialViewController")
    navigationController?.pushViewController(secondTutorial, animated: true)
  }
  
}
