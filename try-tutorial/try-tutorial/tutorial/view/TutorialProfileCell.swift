//
//  TutorialProfileCell.swift
//  try-tutorial
//
//  Created by Wataru Maeda on 2018-07-16.
//  Copyright © 2018 com.watarumaeda. All rights reserved.
//

import UIKit

class TutorialProfileCell: UITableViewCell {
  
  @IBOutlet weak var collectionView: UICollectionView!
  fileprivate var navigationController: UINavigationController?
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    setupCollectionView()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
}

// MARK: Accessor

extension TutorialProfileCell {
  
  func setNavigationController(_ navigationContoller: UINavigationController) {
    self.navigationController = navigationContoller
  }
}

// MARK: - CollectionView

extension TutorialProfileCell: UICollectionViewDataSource, UICollectionViewDelegate {
  
  fileprivate func setupCollectionView() {
    
    // set collection view UI
    collectionView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0)
    
    // set layout of collectionView
    let space = 10 as CGFloat
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.minimumLineSpacing = space
    flowLayout.minimumInteritemSpacing = space / 2
    flowLayout.sectionInset = UIEdgeInsetsMake(0, space, space, space);
    flowLayout.itemSize = CGSize(
      width: (frame.size.width - space * 4) / 3,
      height: (frame.size.width - space * 4) / 3 * 1.87
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
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let storyboard = UIStoryboard(name: "Tutorial", bundle: Bundle.main)
    let thirdTutorial = storyboard.instantiateViewController(withIdentifier: "ThirdTutorialViewController")
    self.navigationController?.pushViewController(thirdTutorial, animated: true)
  }
  
}
