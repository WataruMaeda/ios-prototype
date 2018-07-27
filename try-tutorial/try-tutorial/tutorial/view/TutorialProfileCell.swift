//
//  TutorialProfileCell.swift
//  try-tutorial
//
//  Created by Wataru Maeda on 2018-07-16.
//  Copyright © 2018 com.watarumaeda. All rights reserved.
//

import UIKit

class TutorialProfileCell: UITableViewCell {
  
  fileprivate var recipes = [Recipe]()
  @IBOutlet weak var collectionView: UICollectionView!
  fileprivate var navigationController: UINavigationController?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setRecipeList()
    setupCollectionView()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
}

// MARK: Accessor

extension TutorialProfileCell {
  
  func setRecipeList() {
    recipes = TutorialModelManager.getRecipeList() ?? [Recipe]()
  }
  
  func setNavigationController(_ navigationContoller: UINavigationController) {
    self.navigationController = navigationContoller
  }
}

// MARK: - CollectionView

extension TutorialProfileCell: UICollectionViewDataSource, UICollectionViewDelegate {
  
  fileprivate func setupCollectionView() {
    
    // set collection view UI
    collectionView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0)
    collectionView.isScrollEnabled = false
    
    // set layout of collectionView
    let space = 5 as CGFloat
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.minimumLineSpacing = space
    flowLayout.minimumInteritemSpacing = space / 2
    flowLayout.sectionInset = UIEdgeInsetsMake(0, space, space, space);
    flowLayout.itemSize = CGSize(
      width: (UIScreen.main.bounds.size.width - space * 4) / 3,
      height: (UIScreen.main.bounds.size.width - space * 4) / 3 * 1.87
    )
    collectionView.setCollectionViewLayout(flowLayout, animated: true, completion: nil)
    
    // set delegate & datasorce
    collectionView.delegate = self
    collectionView.dataSource = self
    UIView.animate(withDuration: 0, animations: {
      self.collectionView.reloadData()
    }) { finished in
      if finished {
        self.shakeRecipe()
      }
    }
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    return recipes.count
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? TutorialCosmeCell else {
      return UICollectionViewCell()
    }
    cell.setupContents(recipes[indexPath.row])
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if indexPath.row != 0 { return }
    let storyboard = UIStoryboard(name: "Tutorial", bundle: Bundle.main)
    let thirdTutorial = storyboard.instantiateViewController(withIdentifier: "ThirdTutorialViewController")
    self.navigationController?.pushViewController(thirdTutorial, animated: true)
  }
  
  func shakeRecipe() {
      
    let indexPath = IndexPath(row: 0, section: 0)
    guard let cell = self.collectionView.cellForItem(at: indexPath) else { return }
    
    // shake animation
    let animation = CAKeyframeAnimation(keyPath:"transform")
    let angle = 0.05 as CGFloat
    animation.values = [CATransform3DMakeRotation(angle, 0.0, 0.0, 1.0),
                        CATransform3DMakeRotation(-angle, 0.0, 0.0, 1.0)]
    animation.autoreverses = true
    animation.duration = 0.2
    animation.repeatCount = 2
    cell.layer.add(animation, forKey: "position")
  }
}
