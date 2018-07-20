//
//  ThirdTutorialViewController.swift
//  try-tutorial
//
//  Created by Wataru Maeda on 2018-07-03.
//  Copyright © 2018 com.watarumaeda. All rights reserved.
//

import UIKit

class ThirdTutorialViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setupTableView()
    setupPager()
  }
}

// MARK: TableView

extension ThirdTutorialViewController: UITableViewDelegate, UITableViewDataSource {
  
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
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 1918
  }
}

// MARK: - Page Control

extension ThirdTutorialViewController {
  
  func setupPager() {
    
    // get pager from xib
    let nib = UINib(nibName: "TutorialPager", bundle: nil)
    let subviews = nib.instantiate(withOwner: self, options: nil)
    guard let pager = subviews.first as? TutorialPager else { return }
    pager.frame = CGRect(x: 0, y: view.frame.size.height - 178,
                         width: view.frame.size.width, height: 178)
    
    // add skip action
    pager.skipButton.addTarget(self,action: #selector(tappedSkip), for: .touchUpInside)
    
    // setup shadow
    pager.layer.shadowColor = UIColor.lightGray.cgColor
    pager.layer.shadowOffset = CGSize(width: 0, height: -1);
    pager.layer.masksToBounds = false
    pager.layer.shadowOpacity = 0.2
    
    // setup contents
    pager.setupContents(3)
    pager.setupContents(4)
    
    view.addSubview(pager)
  }
  
  @objc func tappedSkip() {
    
    // scroll to bottom
    tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .bottom, animated: true)
    
    // setup contents
//    pager.setupContents(4)
  }
}
