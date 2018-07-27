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
  
  override func viewWillAppear(_ animated: Bool) {
    title = "プロフィール"
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    title = ""
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

// MARK: - Speech Baloon

extension SecondTutorialViewController {
  
  func showSpeechBaloon() {
    
    // get nib
    let nib = UINib(nibName: "TutorialSpeechBaloon", bundle: nil)
    let subviews = nib.instantiate(withOwner: self, options: nil)
      
    let indexPath = IndexPath(row: 0, section: 0)
    let cellRect = self.tableView.rectForRow(at: indexPath)
    
    // create baloon
    let speechBaloonView = subviews.first as! TutorialSpeechBaloon
    speechBaloonView.frame = CGRect(x: self.view.frame.size.width / 3 / 3 * 2 + 10,
                                    y: cellRect.origin.y,
                                    width: self.view.frame.size.width / 3,
                                    height: self.view.frame.size.width / 3)
    speechBaloonView.label.text = "気になる\nメイクを\n見つけよう"
    speechBaloonView.alpha = 0
    self.view.addSubview(speechBaloonView)
    
    // animation
    UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseIn], animations: {
      
      // fade in animation
      speechBaloonView.alpha = 1
      
    }, completion: nil)
  }
}


// MARK: TableView

extension SecondTutorialViewController: UITableViewDelegate, UITableViewDataSource {
  
  func setupTableView() {
    tableView.dataSource = self
    tableView.delegate = self
    tableView.isScrollEnabled = false
    UIView.animate(withDuration: 0, animations: {
      self.tableView.reloadData()
    }) { finished in
      if finished {
        self.setupPager()
        self.showSpeechBaloon()
      }
    }
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return (view.frame.size.width - 40) / 3 * 1.87 * 3 + 60
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
    pager.setupContents(2)
    
    view.addSubview(pager)
    
    // animation
    var pagerOrigin = pager.frame.origin
    pagerOrigin.y = view.frame.size.height - 178
    UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseIn], animations: {
      pager.frame.origin = pagerOrigin
    }, completion: nil)
  }
  
  @objc func tappedSkip() {
    let storyboard = UIStoryboard(name: "Tutorial", bundle: Bundle.main)
    let thirdTutorial = storyboard.instantiateViewController(withIdentifier: "ThirdTutorialViewController")
    navigationController?.pushViewController(thirdTutorial, animated: true)
  }
}
