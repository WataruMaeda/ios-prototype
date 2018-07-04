//
//  FirstTutorialViewController.swift
//  try-tutorial
//
//  Created by Wataru Maeda on 2018-07-03.
//  Copyright © 2018 com.watarumaeda. All rights reserved.
//

import UIKit

class FirstTutorialViewController: UIViewController {
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setupNavigationItems()
    setupCollectionView()
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

// MARK: - CollectionView

extension FirstTutorialViewController: UICollectionViewDataSource, UICollectionViewDelegate {
  
  fileprivate func setupCollectionView() {
    
    // set collection view UI
    collectionView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0)
    
    
    // set layout of collectionView
    let space = 10 as CGFloat
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.minimumLineSpacing = space
    flowLayout.minimumInteritemSpacing = space
    flowLayout.sectionInset = .zero;
    flowLayout.headerReferenceSize = CGSize(
      width: collectionView.frame.size.width,
      height: 70
    )
    flowLayout.itemSize = CGSize(
      width: (collectionView.frame.size.width - space * 4) / 3,
      height: (collectionView.frame.size.width - space * 4) / 3 * 1.3
    )
    collectionView.setCollectionViewLayout(flowLayout, animated: true, completion: nil)
    
    // set delegate & datasorce
    collectionView.delegate = self
    collectionView.dataSource = self
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    return 10
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
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
    
    return kind == UICollectionElementKindSectionHeader ? header : UICollectionReusableView()
  }
  
}
