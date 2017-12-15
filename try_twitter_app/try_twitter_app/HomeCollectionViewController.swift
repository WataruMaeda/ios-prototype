//
//  HomeCollectionCollectionViewController.swift
//  try_twitter_app
//
//  Created by Wataru Maeda on 2017/12/15.
//  Copyright © 2017 com.watarumaeda. All rights reserved.
//

import UIKit

class WordCell: UICollectionViewCell {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  let wordLabel: UILabel = {
    let label = UILabel()
    label.text = "TEST TEST TEST"
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  func setupViews() {
    backgroundColor = .yellow
    addSubview(wordLabel)
    wordLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    wordLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
    wordLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    wordLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init has not been inplemented")
  }
}

class HomeCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  
  let reuseIdentifer = "cellId"
  let headerCellId = "headerCellId"
  let footerCellId = "footerCellId"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView?.backgroundColor = .white
    collectionView?.register(WordCell.self, forCellWithReuseIdentifier: reuseIdentifer)
    collectionView?.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerCellId)
    collectionView?.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: footerCellId)
    
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 4
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifer, for: indexPath)
    return cell
  }
  
  override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    if kind == UICollectionElementKindSectionHeader {
      let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerCellId, for: indexPath)
      header.backgroundColor = .red
      return header
    } else {
      let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerCellId, for: indexPath)
      footer.backgroundColor = .blue
      return footer
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.frame.size.width, height: 50)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return CGSize(width: view.frame.size.width, height: 50)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
    return CGSize(width: view.frame.size.width, height: 50)
  }
}
