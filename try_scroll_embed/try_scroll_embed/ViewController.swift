//
//  ViewController.swift
//  try_scroll_embed
//
//  Created by Wataru Maeda on 2018/01/23.
//  Copyright © 2018 com.watarumaeda. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate {

  var headerImage: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 300)
    imageView.image = #imageLiteral(resourceName: "header")
    return imageView
  }()
  
  @IBOutlet var tableView: UITableView! {
    didSet {
      tableView.tableHeaderView = headerImage
      tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
      tableView.delegate = self
      tableView.dataSource = self
    }
  }
  
  let contentViewController = EmbededViewController()
  
  lazy var gesture: UIPanGestureRecognizer = {
    let gesture = UIPanGestureRecognizer()
    gesture.delegate = self
    gesture.addTarget(self, action: #selector(exePan(_:)))
    return gesture
  }()
  
  var currentPanY = 0 as CGFloat
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.addGestureRecognizer(gesture)
  }
  
  func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    return true
  }
  
  @objc private func exePan(_ recognizer: UIPanGestureRecognizer) {
    
    if recognizer.state != .changed {
      
      currentPanY = 0
      tableView.isScrollEnabled = false
      contentViewController.tableView.isScrollEnabled = false
      
    } else {
      let headerHeight = 300 as CGFloat
      let distamceY = recognizer.translation(in: tableView).y
      
      print(distamceY)
      
      // header presenting
      if tableView.contentOffset.y >= -headerHeight &&
         tableView.contentOffset.y <= headerHeight {
        tableView.contentOffset.y = -distamceY
      // subview's sctoll presenting
      } else if contentViewController.tableView.contentOffset.y >= 0 {
        
        contentViewController.tableView.contentOffset.y = -distamceY - headerHeight
        contentViewController.tableView.isScrollEnabled = true
      } else {
        
      }
      
    }
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UIScreen.main.bounds.height
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    guard let subview = contentViewController.view else { return UITableViewCell() }
    cell.addSubview(subview)
    contentViewController.didMove(toParentViewController: self)
    return cell
  }
}

