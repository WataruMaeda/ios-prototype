//
//  ViewController.swift
//  try_flicker
//
//  Created by Wataru Maeda on 2017/11/02.
//  Copyright © 2017 Wataru Maeda. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
  
  var cv: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupSearchBar()
    setupCollectionView()
  }
}

// MARK: - UISearchBar

extension HomeViewController: UISearchBarDelegate {
  
  func setupSearchBar() {
    let sb = UISearchBar()
    sb.sizeToFit()
    sb.delegate = self
    navigationItem.titleView = sb
  }
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    print(searchText)
  }
}

// MARK: - UICollectionView

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
  
  func setupCollectionView() {
    // Collection View Layout
    let space = 5.0 as CGFloat
    let cvLayout = UICollectionViewFlowLayout()
    cvLayout.scrollDirection = .vertical
    cvLayout.minimumLineSpacing = space
    cvLayout.minimumInteritemSpacing = space / 2
    cvLayout.sectionInset = UIEdgeInsetsMake(space, space, space, space)
    cvLayout.itemSize = CGSize(
      width: (view.frame.size.width - space * 5) / 4,
      height: (view.frame.size.width - space * 5) / 4)
    
    // Collection View
    cv = UICollectionView(frame:CGRect(x: 0, y: 0,
                                       width: view.frame.size.width,
                                       height: view.frame.size.height),
                          collectionViewLayout: cvLayout)
    cv.backgroundColor = .white
    cv.delegate = self
    cv.dataSource = self
    view.addSubview(cv)
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 50
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let identifer = "cell"
    collectionView.register(FlickerCell.self, forCellWithReuseIdentifier: identifer)
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifer, for: indexPath) as? FlickerCell else { return UICollectionViewCell() }
    cell.setup()
    return cell
  }
}

// MARK: - UICollectionViewCell

class FlickerCell: UICollectionViewCell {
  var imageView = UIImageView()
  var overlay = UIView()
  var label = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    initViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
    initViews()
  }
  
  private func initViews() {
    addSubview(imageView)
    addSubview(overlay)
    addSubview(label)
  }
  
  override func draw(_ rect: CGRect) {
    imageView.frame = rect
    overlay.frame = rect
    label.frame = rect
  }
  
  func setup() {
    
  }
}
