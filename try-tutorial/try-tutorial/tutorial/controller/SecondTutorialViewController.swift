//
//  SecondTutorialViewController.swift
//  try-tutorial
//
//  Created by Wataru Maeda on 2018-07-03.
//  Copyright © 2018 com.watarumaeda. All rights reserved.
//

import UIKit

class SecondTutorialViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var headerView: UIView!
  @IBOutlet weak var profileImage: UIImageView!
  @IBOutlet weak var bgImage: UIImageView!
  @IBOutlet weak var followingButton: UIButton!
  @IBOutlet weak var followerButton: UIButton!
  @IBOutlet weak var followButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setupProfile()
    setupTableView()
    setupPager()
  }
}

// MARK: Header

extension SecondTutorialViewController {
  
  func setupProfile() {
    // profile image
    profileImage.layer.borderColor = UIColor.white.cgColor
    profileImage.layer.cornerRadius = 8
    profileImage.layer.borderWidth = 1.5
    profileImage.clipsToBounds = true
    
    // buttons
    [followingButton, followerButton].forEach { button in
      button?.layer.borderColor = UIColor(red:0.594, green:0.857, blue:0.917, alpha:1.000).cgColor
      button?.layer.cornerRadius = 15
      button?.layer.borderWidth = 1.5
      button?.clipsToBounds = true
    }
    followButton.layer.cornerRadius = 15
    followButton.clipsToBounds = true
  }
}

// MARK: TableView

extension SecondTutorialViewController: UITableViewDelegate, UITableViewDataSource {
  
  func setupTableView() {
    tableView.dataSource = self
    tableView.delegate = self
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? TutorialProfileCell else {
      return UITableViewCell()
    }
    if let navigationController = navigationController {
      cell.setNavigationController(navigationController)
    }
    return cell
  }
}

// MARK: - Page Control

extension SecondTutorialViewController {
  
  func setupPager() {
    
    // get pager from xib
    let nib = UINib(nibName: "TutorialPager", bundle: nil)
    let subviews = nib.instantiate(withOwner: self, options: nil)
    guard let pager = subviews.first as? TutorialPager else { return }
    pager.frame = CGRect(x: 0, y: view.frame.size.height - 200,
                         width: view.frame.size.width, height: 200)
    
    // add skip action
    pager.skipButton.addTarget(self,action: #selector(tappedSkip), for: .touchUpInside)
    
    // setup shadow
    pager.layer.shadowColor = UIColor.lightGray.cgColor
    pager.layer.shadowOffset = CGSize(width: 0, height: -1);
    pager.layer.masksToBounds = false
    pager.layer.shadowOpacity = 0.2
    
    view.addSubview(pager)
  }
  
  @objc func tappedSkip() {
    print("tapped skip")
  }
}
