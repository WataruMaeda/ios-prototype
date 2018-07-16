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
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
    return cell ?? UITableViewCell()
  }
  
}
